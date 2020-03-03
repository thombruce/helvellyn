<template lang="pug">
div
  h1 Posts

  router-link(:to="{ name: 'new_post_path' }") New post

  table.table(v-if="posts")
    thead.thead-dark
      tr
        th Title
        th Content
        th Actions
    tbody
      tr(v-for="post in posts")
        td
          router-link(:to="{ name: 'post_path', params: { id: post.id } }") {{ post.title }}
        td(v-html="post.content")
        td
          router-link.mr-1(:to="{ name: 'post_path', params: { id: post.id } }") View
          router-link.mr-1(:to="{ name: 'edit_post_path', params: { id: post.id } }") Edit

  p.lead.text-center(v-else) No items to show.
</template>

<script>
export default {
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
