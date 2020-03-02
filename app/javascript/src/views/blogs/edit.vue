<template lang="pug">
layout
  h1 Edit Blog
  blog-form(v-if="blog" :blog="blog", :submit="update")
  a(v-on:click.stop="destroy" href="javascript:;") Delete
  router-link(:to="{ name: 'blog_path' }") Back
</template>

<script>
import Layout from '../layouts/application'
import BlogForm from './_form.vue'
export default {
  components: {
    Layout,
    BlogForm
  },
  data() {
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
    },
    update: function () {
      this.$store.dispatch('blogs/update', { id: this.blog.id, blog: this.blog }).then(() => {
        this.$router.push('/')
      })
    },
    destroy: function () {
      this.$store.dispatch('blogs/destroy', this.blog.id).then(() => {
        this.$router.push('/')
      })
    }
  }
}
</script>
