<template lang="pug">
layout
  h1 New User
  user-form(:user="user")
  router-link(:to="{ name: 'new_session_path' }") Sign in
</template>

<script>
import UserForm from './_form.vue'
export default {
  components: {
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
  }
}
</script>
