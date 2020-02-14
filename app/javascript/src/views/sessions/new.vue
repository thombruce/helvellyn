<template lang="pug">
layout
  h1 New Session
  session-form(:user="user")
  router-link(:to="{ name: 'new_user_path' }") Sign up
</template>

<script>
import Layout from '../layouts/authentication'
import SessionForm from './_form.vue'
export default {
  components: {
    Layout,
    SessionForm
  },
  data() {
    return {
      user: {
        login: '',
        password: ''
      }
    }
  }
}
</script>
