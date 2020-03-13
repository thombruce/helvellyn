<template lang="pug">
div
  h1 New User
  user-form(:user="user" :submit="signUp")
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
        password: '',
        errors: []
      }
    }
  },
  methods: {
    signUp: function () {
      this.$store.dispatch('users/create', { user: this.user }).then(() => {
        this.$router.push('/')
      }).catch((errors) => {
        this.user.errors = errors
      })
    }
  }
}
</script>
