<template lang="pug">
component(:is="fieldComponent" :label="label" v-model="inputVal")
</template>

<script>
import VRichTextEditor from './VRichTextEditor.vue'
import VMarkdownEditor from './VMarkdownEditor.vue'
import HvnDateSelect from './inputs/HvnDateSelect.vue'

export default {
  props: [
    'value',
    'label',
    'type'
  ],
  components: {
    VRichTextEditor,
    VMarkdownEditor,
    HvnDateSelect
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
        case 'Date':
          return 'hvn-date-select'
        case 'Markdown':
          return 'v-markdown-editor'
        default:
          return 'v-text-field'
      }
    }
  }
}
</script>
