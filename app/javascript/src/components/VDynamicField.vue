<template lang="pug">
component(:is="fieldComponent" :label="label" v-model="inputVal")
</template>

<script>
import VRichTextEditor from './VRichTextEditor.vue'
import VMarkdownEditor from './VMarkdownEditor.vue'

export default {
  props: [
    'value',
    'label',
    'type'
  ],
  components: {
    VRichTextEditor,
    VMarkdownEditor
  },
  computed: {
    inputVal: {
      get() {
        return this.value
      },
      set(val) {
        this.$emit('input', val)
      }
    },
    fieldComponent() {
      switch(this.type) {
        case 'String':
          return 'v-text-field'
        case 'Text':
          return 'v-textarea'
        case 'Rich Text':
          return 'v-rich-text-editor'
        case 'Markdown':
          return 'v-markdown-editor'
        default:
          return 'v-text-field'
      }
    }
  }
}
</script>
