<template lang="pug">
div
  h1 Edit Post
  post-form(v-if="post" :post="post", :submit="update")
  a(v-on:click.stop="destroy" href="javascript:;") Delete
  router-link(:to="{ name: 'post_path' }") Back
</template>

<script>
import PostForm from './_form.vue'
export default {
  components: {
    PostForm
  },
  data() {
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
    },
    update: function () {
      this.$store.dispatch('posts/update', { id: this.post.id, post: this.post }).then(() => {
        this.$router.push('/')
      })
    },
    destroy: function () {
      this.$store.dispatch('posts/destroy', this.post.id).then(() => {
        this.$router.push('/')
      })
    }
  }
}
</script>
