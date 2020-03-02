<template lang="pug">
layout
  h1 Blogs

  router-link(:to="{ name: 'new_blog_path' }") New blog

  table.table(v-if="blogs")
    thead.thead-dark
      tr
        th Title
        th Content
        th Actions
    tbody
      tr(v-for="blog in blogs")
        td
          router-link(:to="{ name: 'blog_path', params: { id: blog.id } }") {{ blog.title }}
        td(v-html="blog.content")
        td
          router-link.mr-1(:to="{ name: 'blog_path', params: { id: blog.id } }") View
          router-link.mr-1(:to="{ name: 'edit_blog_path', params: { id: blog.id } }") Edit

  p.lead.text-center(v-else) No items to show.
</template>

<script>
import Layout from '../layouts/application'
export default {
  components: {
    Layout
  },
  data () {
    return {
      blogs: null
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
      this.blogs = null
      this.$store.dispatch('blogs/index').then(() => {
        this.blogs = this.$store.state.blogs.list
      })
    }
  }
}
</script>
