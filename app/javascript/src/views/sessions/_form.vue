<template lang="pug">
v-form(ref="form" :model="user")
  v-text-field(label="Login" v-model="user.login" :error-messages="user.errors.login")
  v-text-field(label="Password" type="password" v-model="user.password" :error-messages="user.errors.password")
  v-btn(color="primary" @click="login") Login
</template>

<script>
export default {
  props: ['user'],
  methods: {
    login: function () {
      this.$store.dispatch('sessions/create', { session: this.user }).then(() => {
        this.$router.push('/')
      }).catch((errors) => {
        this.user.errors = errors
      })
    }
  }
}
</script>
