<template lang="pug">
div
  div(v-if="post")
    h2(v-html="post.title")
    p(v-html="post.content")
    router-link(:to="{ name: 'edit_post_path', params: { postId: post.id } }") Edit
</template>

<script>
export default {
  data () {
    return {
      post: null
    }
  },
  created () {
    this.fetchData()
  },
  watch: {
    '$route': 'fetchData'
  },
  methods: {
    fetchData () {
      this.post = null
      this.$store.dispatch('posts/show', this.$route.params.postId).then(() => {
        this.post = this.$store.state.posts.list[this.$route.params.postId]
      })
    }
  }
}
</script>
