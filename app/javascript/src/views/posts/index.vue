<template lang="pug">
layout
  h1 Posts

  div(v-if="posts")
    div(v-for="post in posts")
      p(v-html="post.content")
      router-link(:to="{ name: 'post_path', params: { id: post.id } }") View
      router-link(:to="{ name: 'edit_post_path', params: { id: post.id } }") Edit

  p.lead.text-center(v-else) No items to show.

  router-link(:to="{ name: 'new_post_path' }") New post
</template>

<script>
import Layout from '../layouts/application'
export default {
  components: {
    Layout
  },
  data () {
    return {
      posts: null
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
      this.posts = null
      this.$store.dispatch('posts/index').then(() => {
        this.posts = this.$store.state.posts.list
      })
    }
  }
}
</script>
