<template lang="pug">
div
  h1 Confirming your Account
</template>

<script>
export default {
  data() {
    return {
      user: {
        errors: []
      }
    }
  },
  created () {
    this.fetchData()
  },
  methods: {
    fetchData () {
      this.user = null
      this.$store.dispatch('authentication/confirm', { confirmation_token: this.$route.params.confirmation_token, email: this.$route.query.email }).then(() => {
        this.$router.push({ name: 'account_path' })
      })
    }
  }
}
</script>
