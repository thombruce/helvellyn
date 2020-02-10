<template lang="pug">
form(@submit.prevent="login")
  .form-group
    label(for="loginInput") Login
    input#loginInput.form-control(v-model="user.login")
  .form-group
    label(for="passwordInput") Password
    input#passwordInput.form-control(type="password" v-model="user.password")
  button(type="submit") Login
</template>

<script>
export default {
  props: ['user'],
  methods: {
    login: function () {
      this.$store.dispatch('sessions/create', { session: this.user }).then(() => {
        this.$router.push('/')
      })
    }
  }
}
</script>
