<template lang="pug">
div
  h1 New Session
  session-form(:user="user")
  router-link(:to="{ name: 'new_user_path' }") Sign up
</template>

<script>
import SessionForm from './_form.vue'
export default {
  components: {
    SessionForm
  },
  data() {
    return {
      user: {
        login: '',
        password: '',
        errors: []
      }
    }
  }
}
</script>
