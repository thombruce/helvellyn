<template lang="pug">
form(@submit.prevent="signUp")
  .form-group
    label(for="nameInput") Name
    input#nameInput.form-control(v-model="user.name")
  .form-group
    label(for="emailInput") Email
    input#emailInput.form-control(type="email" v-model="user.email")
  .form-group
    label(for="passwordInput") Password
    input#passwordInput.form-control(type="password" v-model="user.password")
  button(type="submit") Submit
</template>

<script>
export default {
  props: ['user'],
  methods: {
    signUp: function () {
      this.$store.dispatch('users/create', { user: this.user }).then(() => {
        this.$router.push('/')
      })
    }
  }
}
</script>
