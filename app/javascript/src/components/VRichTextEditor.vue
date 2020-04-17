<template lang="pug">
div.mb-4
  v-label {{ label }}
  v-card
    editor-menu-bar(:editor="editor" v-slot="{ commands, isActive }")
      v-toolbar(color="primary" dark dense flat)
        v-menu
          template(v-slot:activator="{ on }")
            v-btn(
              icon
              v-on="on"
              :input-value="isActive.heading()"
            )
              v-icon mdi-format-title
          v-list
            v-list-item(
              :input-value="isActive.heading({ level: 1 })"
              @click="commands.heading({ level: 1 })"
            )
              v-list-item-title Heading 1
            v-list-item(
              :input-value="isActive.heading({ level: 2 })"
              @click="commands.heading({ level: 2 })"
            )
              v-list-item-title Heading 2
            v-list-item(
              :input-value="isActive.heading({ level: 3 })"
              @click="commands.heading({ level: 3 })"
            )
              v-list-item-title Heading 3
        v-divider.mx-2(vertical)
        v-btn(icon :input-value="isActive.bold()" @click="commands.bold")
          v-icon mdi-format-bold
        v-btn(icon :input-value="isActive.italic()" @click="commands.italic")
          v-icon mdi-format-italic
        v-btn(icon :input-value="isActive.strike()" @click="commands.strike")
          v-icon mdi-format-strikethrough
        v-divider.mx-2(vertical)
        v-btn(icon :input-value="isActive.horizontal_rule()" @click="commands.horizontal_rule")
          v-icon mdi-minus
        v-btn(icon :input-value="isActive.blockquote()" @click="commands.blockquote")
          v-icon mdi-format-quote-close
        v-btn(icon :input-value="isActive.bullet_list()" @click="commands.bullet_list")
          v-icon mdi-format-list-bulleted
        v-btn(icon :input-value="isActive.ordered_list()" @click="commands.ordered_list")
          v-icon mdi-format-list-numbered
        //v-btn(icon :input-value="isActive.todo_list()" @click="commands.todo_list") // [1]
        //  v-icon mdi-format-list-checkbox // [1]
        v-divider.mx-2(vertical)
        //v-btn(icon :input-value="isActive.table()" @click="commands.createTable({rowsCount: 3, colsCount: 3, withHeaderRow: false })")
        //  v-icon mdi-table
        rte-image-dialog(:command="commands.image")
        //v-btn(icon :input-value="isActive.image()" @click="commands.image")
        //  v-icon mdi-image
        //v-btn(icon :input-value="isActive.link()" @click="commands.link")
        //  v-icon mdi-link
        v-divider.mx-2(vertical)
        v-btn(icon :input-value="isActive.code()" @click="commands.code")
          v-icon mdi-code-tags
        v-btn(icon :input-value="isActive.code_block()" @click="commands.code_block")
          v-icon mdi-code-brackets
        v-divider.mx-2(vertical)
        v-btn(icon @click="commands.undo")
          v-icon mdi-undo
        v-btn(icon @click="commands.redo")
          v-icon mdi-redo
    v-container
      editor-menu-bubble(:editor="editor" keep-in-bounds v-slot="{ commands, isActive, getMarkAttrs, menu }")
        .menububble(
          :class="{ 'is-active': menu.isActive }"
          :style="`left: ${menu.left}px; bottom: ${menu.bottom}px;`"
        )
          v-btn(icon dark :input-value="isActive.bold()" @click="commands.bold")
            v-icon mdi-format-bold
          v-btn(icon dark :input-value="isActive.italic()" @click="commands.italic")
            v-icon mdi-format-italic
          v-btn(icon dark :input-value="isActive.strike()" @click="commands.strike")
            v-icon mdi-format-strikethrough
          v-btn(icon dark :input-value="isActive.code()" @click="commands.code")
            v-icon mdi-code-tags
          v-form(v-if="linkMenuIsActive" @submit.prevent="setLinkUrl(commands.link, linkUrl)")
            v-text-field.ma-0.pa-0(
              label="URL"
              dark
              dense
              hide-details
              single-line
              clearable
              v-model="linkUrl"
              @keydown.esc="hideLinkMenu"
              @click:clear="setLinkUrl(commands.link, null)"
            )
          template(v-else)
            v-btn(icon dark :input-value="isActive.link()" @click="showLinkMenu(getMarkAttrs('link'))")
              v-icon mdi-link

      editor-floating-menu(:editor="editor" v-slot="{ commands, isActive, getMarkAttrs, menu }")
        .floating-menu(
          :class="{ 'is-active': menu.isActive }"
          :style="`top: ${menu.top}px`"
        )
          v-btn(icon small :input-value="isActive.heading({ level: 1 })" @click="commands.heading({ level: 1 })")
            v-icon mdi-format-header-1
          v-btn(icon small :input-value="isActive.heading({ level: 2 })" @click="commands.heading({ level: 2 })")
            v-icon mdi-format-header-2
          v-btn(icon small :input-value="isActive.heading({ level: 3 })" @click="commands.heading({ level: 3 })")
            v-icon mdi-format-header-3
          v-divider.mx-2(vertical)
          v-btn(icon :input-value="isActive.horizontal_rule()" @click="commands.horizontal_rule")
            v-icon mdi-minus
          v-btn(icon :input-value="isActive.blockquote()" @click="commands.blockquote")
            v-icon mdi-format-quote-close
          v-divider.mx-2(vertical)
          rte-image-dialog(:command="commands.image")
          v-divider.mx-2(vertical)
          v-btn(icon :input-value="isActive.code_block()" @click="commands.code_block")
            v-icon mdi-code-brackets

      editor-content.rte-content(:editor="editor" v-model="inputVal.json")
</template>

<script>
import { Editor, EditorContent, EditorMenuBar, EditorMenuBubble, EditorFloatingMenu } from 'tiptap'
import {
  Blockquote,
  CodeBlock,
  HorizontalRule,
  Heading,
  OrderedList,
  BulletList,
  ListItem,
  //TodoItem, // [1]
  //TodoList, // [1]
  Bold,
  Code,
  Italic,
  Link,
  Strike,
  Underline,
  History,
  Image,
  Table,
  TableHeader,
  TableRow,
  TableCell,
  TrailingNode
} from 'tiptap-extensions'

import RteImageDialog from './VRichTextEditor/RteImageDialog'

export default {
  props: [
    'label',
    'value'
  ],
  components: {
    EditorContent,
    EditorMenuBar,
    EditorMenuBubble,
    EditorFloatingMenu,
    RteImageDialog
  },
  data() {
    return {
      editor: null,
      linkUrl: null,
      linkMenuIsActive: false
    }
  },
  computed: {
    inputVal: {
      get() {
        return this.value || {}
      },
      set(val) {
        this.$emit('input', val)
      }
    }
  },
  methods: {
    showLinkMenu(attrs) {
      this.linkUrl = attrs.href
      this.linkMenuIsActive = true
      this.$nextTick(() => {
        this.$refs.linkInput.focus()
      })
    },
    hideLinkMenu() {
      this.linkUrl = null
      this.linkMenuIsActive = false
    },
    setLinkUrl(command, url) {
      command({ href: url })
      this.hideLinkMenu()
    }
  },
  mounted() {
    this.editor = new Editor({
      extensions: [
        new Blockquote(),
        new CodeBlock(),
        new HorizontalRule(),
        new Heading({ levels: [1, 2, 3] }),
        new BulletList(),
        new OrderedList(),
        new ListItem(),
        //new TodoItem(), // [1]
        //new TodoList(), // [1]
        new Bold(),
        new Code(),
        new Italic(),
        new Link(),
        new Strike(),
        new Underline(),
        new History(),
        new Image(),
        new Table(),
        new TableHeader(),
        new TableCell(),
        new TableRow(),
        new TrailingNode({
          node: 'paragraph',
          notAfter: ['heading', 'paragraph']
        })
      ],
      onUpdate: ({getJSON, getHTML}) => {
        const json = getJSON()
        const html = getHTML()
        const newValue = { json, html }
        this.$emit('input', newValue)
      },
      content: this.inputVal.json
    })
  },
  beforeDestroy() {
    this.editor.destroy()
  }
}

// TODO: Add table support
// TODO: Add image upload support
// TODO: Add formatting to display for better previewing
//       - blockquote

// NOTE: Todo list support pending on resolution of [1]

// [1] Todo list fails for some reason.
//     Possibly... runtime-only build issue? But... we definitely have Vue setup for both... locally, anyway.
//     Initial error is: "TypeError: h.hasAttribute is not a function"
//
//     Possibly related issues:
//     - https://github.com/scrumpy/tiptap/issues/69
//     - https://github.com/scrumpy/tiptap/issues/428
//
//     Possible solution:
//     - https://github.com/scrumpy/tiptap/pull/576
</script>

<style lang="scss">
@import 'node_modules/vuetify/src/styles/settings/_variables.scss';
@import 'node_modules/vuetify/src/styles/elements/_blockquote.sass';

.ProseMirror[contenteditable]:focus {
  outline: 0px solid transparent;
}

.rte-content {
  pre > code {
    padding:10px;
    &:before, &:after {
      content: "";
    }
  }

  img {
    max-width: 100%;
  }

  table {
    width: 100%;
    text-align: center;
    th {
      // color: #eee;
      // background-color: #333;
    }
    td {
      // background-color: #eee;
    }
  }

  blockquote {
    @extend .blockquote;
  }

  // ul[data-type="todo_list"] {
  //   padding-left: 0;

  //   li[data-type="todo_item"] {
  //     display: flex;
  //     flex-direction: row;

  //     .todo-checkbox {
  //       border: 2px solid black;
  //       height: 0.9em;
  //       width: 0.9em;
  //       box-sizing: border-box;
  //       margin-right: 10px;
  //       margin-top: 0.3rem;
  //       user-select: none;
  //       -webkit-user-select: none;
  //       cursor: pointer;
  //       border-radius: 0.2em;
  //       background-color: transparent;
  //       transition: 0.4s background;
  //     }
  //     .todo-content {
  //       flex: 1;
  //       > p:last-of-type {
  //         margin-bottom: 0;
  //       }
  //       > ul[data-type="todo_list"] {
  //         margin: .5rem 0;
  //       }
  //     }

  //     &[data-done="true"] {
  //       > .todo-content {
  //         > p {
  //           text-decoration: line-through;
  //         }
  //       }
  //       > .todo-checkbox {
  //         background-color: black;
  //       }
  //     }

  //     &[data-done="false"] {
  //       text-decoration: none;
  //     }
  //   }
  // } // [1]
}

.menububble {
  position: absolute;
  display: flex;
  z-index: 20;
  background: black;
  border-radius: 5px;
  padding: 0.3rem;
  margin-bottom: 0.5rem;
  transform: translateX(-50%);
  visibility: hidden;
  opacity: 0;
  transition: opacity 0.2s, visibility 0.2s;

  &.is-active {
    opacity: 1;
    visibility: visible;
  }

  // &__button {
  //   display: inline-flex;
  //   background: transparent;
  //   border: 0;
  //   color: white;
  //   padding: 0.2rem 0.5rem;
  //   margin-right: 0.2rem;
  //   border-radius: 3px;
  //   cursor: pointer;

  //   &:last-child {
  //     margin-right: 0;
  //   }

  //   &:hover {
  //     background-color: rgba(white, 0.1);
  //   }

  //   &.is-active {
  //     background-color: rgba(white, 0.2);
  //   }
  // }

  // &__form {
  //   display: flex;
  //   align-items: center;
  // }

  // &__input {
  //   font: inherit;
  //   border: none;
  //   background: transparent;
  //   color: white;
  // }
}

.floating-menu {
  position: absolute;
  z-index: 1;
  margin-top: -0.25rem;
  visibility: hidden;
  opacity: 0;
  transition: opacity 0.2s, visibility 0.2s;
  &.is-active {
    opacity: 1;
    visibility: visible;
  }
}
</style>
