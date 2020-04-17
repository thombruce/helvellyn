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
      this.$store.dispatch('authentication/confirm', { confirmation_token: this.$route.params.confirmation_token }).then(() => {
        this.$router.push({ name: 'root_path' })
      })
    }
  }
}
</script>
