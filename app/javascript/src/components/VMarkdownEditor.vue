<template lang="pug">
div
  v-label {{ label }}
  .markdown-editor.mb-4
    v-tabs-slider
    v-tabs(v-model="tab")
      v-tab(key="editTab")
        | Edit
      v-tab(key="previewTab")
        | Preview
    v-tabs-items(v-model="tab")
      v-tab-item(key="editTab")
        v-textarea(v-model="inputVal" no-resize hide-details)
      v-tab-item(key="previewTab")
        .preview(v-html="asHtml")
</template>

<script>
import marked from 'marked'
import DOMPurify from 'dompurify'

export default {
  props: [
    'label',
    'value'
  ],
  data() {
    return {
      tab: null
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
    },
    asHtml() {
      return this.value ? DOMPurify.sanitize(marked(this.value)) : ''
    }
  }
}
</script>

<style lang="scss">
.markdown-editor {
  textarea {
    height: 300px;
  }
  div.preview {
    height: 300px;
    margin-top: 10px;
    overflow-x: hidden;
    overflow-y: scroll;
  }
}
</style>
