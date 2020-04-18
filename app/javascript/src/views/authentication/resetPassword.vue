<template lang="pug">
div
  h1 Reset Password
  v-form(ref="form" :model="user" @submit.prevent="resetPassword()")
    v-text-field(label="Email" v-model="user.email" :error-messages="user.errors.email")
    v-btn(color="primary" type="submit") Reset password
  p
    | Back to
    |
    router-link(:to="{ name: 'login_path' }") log in.
  p
    | Not got an account?
    |
    router-link(:to="{ name: 'signup_path' }") Sign up
    |
    | instead.
</template>

<script>
export default {
  data() {
    return {
      user: {
        email: '',
        errors: []
      }
    }
  },
  beforeRouteEnter (to, from, next) {
    next(vm => {
      if (vm.currentUser) {
        return next(from || '/')
      }
    })
  },
  methods: {
    resetPassword() {
      this.$store.dispatch('authentication/resetPassword', { user: this.user }).then(() => {
        this.$router.push('/login')
      }).catch((errors) => {
        this.user.errors = errors
      })
    }
  }
}
</script>
