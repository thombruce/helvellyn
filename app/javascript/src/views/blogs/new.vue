<template lang="pug">
layout
  h1 New Blog
  blog-form(:blog="blog" :submit="create")
  router-link(:to="{ name: 'blogs_path' }") Back
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
      blog: {
        title: ''
      }
    }
  },
  methods: {
    create: function () {
      this.$store.dispatch('blogs/create', { blog: this.blog }).then(() => {
        this.$router.push('/')
      })
    }
  }
}
</script>
