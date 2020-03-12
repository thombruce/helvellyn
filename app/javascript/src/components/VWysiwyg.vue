<template lang="pug">
div
  v-label {{ label }}
  tui-editor(v-model="inputVal")
</template>

<script>
import 'tui-editor/dist/tui-editor.css'
import 'tui-editor/dist/tui-editor-contents.css'
import 'codemirror/lib/codemirror.css'
import Editor from '@toast-ui/vue-editor/src/Editor.vue'

export default {
  props: [
    'label',
    'value'
  ],
  components: {
    'tui-editor': Editor
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
  }
}
</script>
