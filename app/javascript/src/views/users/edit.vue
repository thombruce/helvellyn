<template lang="pug">
div(v-if="user")
  h1 Edit {{ user.name }}
  v-form(ref="form" :model="user" @submit="submit")
    v-select(label="Role" :items="roles" v-model="user.role" :error-messages="user.errors.role")
    v-btn(color="primary" type="submit") Submit
</template>

<script>
export default {
  props: ['workspace'],
  data () {
    return {
      user: null,
      roles: [
        { text: 'Admin', value: 'admin' },
        { text: 'Author', value: 'author' }
      ]
    }
  },
  created () {
    this.fetchData()
  },
  watch: {
    '$route': 'fetchData'
  },
  methods: {
    // TODO: Add submit method
    fetchData () {
      this.user = null
      this.$store.dispatch('users/show', { workspace_id: this.$route.params.workspace_id, user_id: this.$route.params.user_id }).then(() => {
        this.user = this.$store.state.users.list[this.$route.params.user_id]
        // this.user = this.$store.getters['users/findBySlug'](this.workspace.id, this.$route.params.user_id)
      })
    }
  }
}
</script>
