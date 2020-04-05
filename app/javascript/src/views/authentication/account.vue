<template lang="pug">
div
  h1 Edit User
  v-form(ref="form" :model="user")
    v-text-field(label="Name" v-model="user.name" :error-messages="user.errors.name")
    v-text-field(label="Email" v-model="user.email" :error-messages="user.errors.email")
    v-text-field(label="Password" type="password" v-model="user.password" :error-messages="user.errors.password")
    v-btn(color="primary" @click="update") Submit
  a(v-on:click.stop="destroy" href="javascript:;") Delete
</template>

<script>
export default {
  data() {
    return {
      user: {
        errors: []
      }
    }
  },
  created () {
    this.fetchData()
  },
  watch: {
    '$route': 'fetchData'
  },
  methods: {
    fetchData () {
      this.user = null
      this.$store.dispatch('users/show', this.currentUser.id).then(() => {
        this.user = this.$store.state.users.list[this.currentUser.id]
      })
    },
    update: function () {
      this.$store.dispatch('users/update', { id: this.user.id, user: this.user }).then(() => {
        this.$router.push('/')
      }).catch((errors) => {
        this.user.errors = errors
      })
    },
    destroy: function () {
      this.$store.dispatch('users/destroy', this.user.id).then(() => {
        this.$router.push('/')
      })
    }
  }
}
</script>
