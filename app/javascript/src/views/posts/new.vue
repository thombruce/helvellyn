<template lang="pug">
layout
  h1 New Post
  post-form(:post="post")
  router-link(:to="{ name: 'posts_path' }") Back
</template>

<script>
import PostForm from './_form.vue'
export default {
  components: {
    PostForm
  },
  data() {
    return {
      post: {
        content: ''
      }
    }
  }
}
</script>
