<template lang="pug">
layout
  h1 Edit Post
  post-form(:post="post")
  router-link(:to="{ name: 'post_path' }") Back
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
