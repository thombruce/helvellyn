<template lang="pug">
div
  h1 New User
  v-form(ref="form" :model="user")
    v-text-field(label="Name" v-model="user.name" :error-messages="user.errors.name")
    v-text-field(label="Email" v-model="user.email" :error-messages="user.errors.email")
    v-text-field(label="Password" type="password" v-model="user.password" :error-messages="user.errors.password")
    v-btn(color="primary" @click="signUp") Sign up
  p
    | Already have an account?
    |
    router-link(:to="{ name: 'login_path' }") Log in
    |
    | instead.
</template>

<script>
export default {
  data() {
    return {
      user: {
        name: '',
        email: '',
        password: '',
        errors: []
      }
    }
  },
  methods: {
    signUp: function () {
      this.$store.dispatch('signup', { user: this.user }).then(() => {
        this.$router.push('/')
      }).catch((errors) => {
        this.user.errors = errors
      })
    }
  }
}
</script>
