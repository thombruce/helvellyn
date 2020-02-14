<template lang="pug">
layout
  h1 New Post
  post-form(:post="post" :submit="create")
  router-link(:to="{ name: 'posts_path' }") Back
</template>

<script>
import Layout from '../layouts/application'
import PostForm from './_form.vue'
export default {
  components: {
    Layout,
    PostForm
  },
  data() {
    return {
      post: {
        content: ''
      }
    }
  },
  methods: {
    create: function () {
      this.$store.dispatch('posts/create', { post: this.post }).then(() => {
        this.$router.push('/')
      })
    }
  }
}
</script>
