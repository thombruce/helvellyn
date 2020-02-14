<template lang="pug">
layout
  h1 New User
  user-form(:user="user" :submit="signUp")
  router-link(:to="{ name: 'new_session_path' }") Sign in
</template>

<script>
import Layout from '../layouts/authentication'
import UserForm from './_form.vue'
export default {
  components: {
    Layout,
    UserForm
  },
  data() {
    return {
      user: {
        name: '',
        email: '',
        password: ''
      }
    }
  },
  methods: {
    signUp: function () {
      this.$store.dispatch('users/create', { user: this.user }).then(() => {
        this.$router.push('/')
      })
    }
  }
}
</script>
