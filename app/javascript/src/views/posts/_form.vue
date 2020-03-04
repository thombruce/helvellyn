<template lang="pug">
form(@submit.prevent="submit")
  .form-group
    label(for="titleInput") Title
    input#titleInput.form-control(v-model="post.title")
  .form-group
    label(for="contentInput") Content
    editor#contentInput(v-model="post.content")
  button.btn.btn-primary(type="submit") Submit
</template>

<script>
import 'tui-editor/dist/tui-editor.css'
import 'tui-editor/dist/tui-editor-contents.css'
import 'codemirror/lib/codemirror.css'
import Editor from '@toast-ui/vue-editor/src/Editor.vue'

export default {
  props: [
    'post',
    'submit'
  ],
  components: {
    'editor': Editor
  }
}
</script>
