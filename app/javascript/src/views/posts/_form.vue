<template lang="pug">
v-form(ref="form" :model="post")
  v-text-field(label="Title" v-model="post.title")
  editor#contentInput(v-model="post.content")
  v-btn(color="primary" @click="submit") Submit
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
