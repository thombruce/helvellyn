<template lang="pug">
div
  h1 Edit User
  user-form(v-if="user" :user="user", :submit="update")
  a(v-on:click.stop="destroy" href="javascript:;") Delete
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
      this.$store.dispatch('users/show', this.$route.params.user_id).then(() => {
        this.user = this.$store.state.users.list[this.$route.params.user_id]
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
