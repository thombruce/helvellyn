<template lang="pug">
layout
  h1 Edit User
  user-form(:user="user")
  router-link(:to="{ name: 'user_path' }") Back
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
