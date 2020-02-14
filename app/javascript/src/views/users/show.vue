<template lang="pug">
layout
  h1 User
  div(v-if="user")
    p(v-html="user.name")
    router-link(:to="{ name: 'edit_user_path', params: { id: user.id } }") Edit
</template>

<script>
import Layout from '../layouts/application'

export default {
  components: {
    Layout
  },
  data () {
    return {
      user: null
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
      this.user = null
      this.$store.dispatch('users/show', this.$route.params.id).then(() => {
        this.user = this.$store.state.users.list[this.$route.params.id]
      })
    }
  }
}
</script>
