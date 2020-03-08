<template lang="pug">
div
  h1 User
  div(v-if="user")
    p(v-html="user.name")
    p(v-html="user.email")
    router-link(:to="{ name: 'edit_user_path', params: { userId: user.id } }") Edit
    v-btn(@click="signOut") Logout
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
    },
    signOut: function () {
      this.$store.dispatch('sessions/destroy').then(() => {
        this.$router.push('/sessions/new')
      })
    }
  }
}
</script>
