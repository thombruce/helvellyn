<template lang="pug">
div
  h2 New Post
  post-form(:post="post" :submit="create")
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
  },
  methods: {
    create: function () {
      this.$store.dispatch('posts/create', { workspaceId: this.$route.params.workspaceId, data: { post: this.post } }).then(() => {
        this.$router.push('/')
      })
    }
  }
}
</script>
