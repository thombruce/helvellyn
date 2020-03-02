<template lang="pug">
layout
  h1 Blog
  div(v-if="blog")
    h2(v-html="blog.title")
    p(v-html="blog.content")
    router-link(:to="{ name: 'edit_blog_path', params: { id: blog.id } }") Edit
</template>

<script>
import Layout from '../layouts/application'

export default {
  components: {
    Layout
  },
  data () {
    return {
      blog: null
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
      this.blog = null
      this.$store.dispatch('blogs/show', this.$route.params.id).then(() => {
        this.blog = this.$store.state.blogs.list[this.$route.params.id]
      })
    }
  }
}
</script>
