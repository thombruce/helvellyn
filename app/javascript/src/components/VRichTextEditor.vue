<template lang="pug">
div
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
        //v-btn(icon :input-value="isActive.image()" @click="commands.image")
        //  v-icon mdi-image
        //v-btn(icon :input-value="isActive.link()" @click="commands.link")
        //  v-icon mdi-link
        //v-divider.mx-2(vertical)
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
      editor-menu-bubble(:editor="editor" keep-in-bounds v-slot="{ commands, isActive, menu }")
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

      editor-content.rte-content(:editor="editor" v-model="inputVal")
</template>

<script>
import { Editor, EditorContent, EditorMenuBar, EditorMenuBubble } from 'tiptap'
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
  TableCell
} from 'tiptap-extensions'

export default {
  props: [
    'label',
    'value'
  ],
  components: {
    EditorContent,
    EditorMenuBar,
    EditorMenuBubble
  },
  data() {
    return {
      editor: null
    }
  },
  computed: {
    inputVal: {
      get() {
        return this.value;
      },
      set(val) {
        this.$emit('input', val);
      }
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
        new TableRow()
      ],
      onUpdate: ({getHTML}) => {
        const state = getHTML()
        this.$emit('input', state)
      },
      content: this.value
    })
  },
  beforeDestroy() {
    this.editor.destroy()
  }
}

// TODO: Add link support
// TODO: Add image support
//       - from url
//       - upload
// TODO: Add table support
// TODO: Add formatting to display for better previewing
//       - blockquote
//       - image max width
//       - appropriate margins and padding

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
</style>
