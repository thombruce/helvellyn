<template lang="pug">
div
  h1 User
  div(v-if="user")
    p(v-html="user.name")
    router-link(:to="{ name: 'edit_user_path', params: { userId: user.id } }") Edit
</template>

<script>
export default {
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
      this.$store.dispatch('users/show', this.$route.params.userId).then(() => {
        this.user = this.$store.state.users.list[this.$route.params.userId]
      })
    }
  }
}
</script>
