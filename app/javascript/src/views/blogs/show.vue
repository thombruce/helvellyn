<template lang="pug">
div
  div(v-if="blog")
    h1(v-html="blog.title")
    p(v-html="blog.content")
    router-link(:to="{ name: 'edit_blog_path', params: { blogId: blog.id } }") Edit
    router-view
</template>

<script>
export default {
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
      this.$store.dispatch('blogs/show', this.$route.params.blogId).then(() => {
        this.blog = this.$store.state.blogs.list[this.$route.params.blogId]
      })
    }
  }
}
</script>
