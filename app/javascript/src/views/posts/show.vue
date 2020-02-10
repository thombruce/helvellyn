<template lang="pug">
layout
  h1 Post
  div(v-if="post")
    p(v-html="post.content")
    router-link(:to="{ name: 'edit_post_path', params: { id: post.id } }") Edit
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
      this.$store.dispatch('posts/show', this.$route.params.id).then(() => {
        this.post = this.$store.state.posts.list[this.$route.params.id]
      })
    }
  }
}
</script>
