<template lang="pug">
div(v-if="user")
  h2 {{ user.name }}
  p
    strong Name
    | &nbsp;
    span {{ user.name }}
  router-link(:to="{ name: 'edit_user_path', params: { workspace_id: workspace.slug } }") Edit
</template>

<script>
export default {
  props: ['workspace'],
  data () {
    return {
      user: null
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
      this.$store.dispatch('users/show', { workspace_id: this.$route.params.workspace_id, user_id: this.$route.params.user_id }).then(() => {
        this.user = this.$store.state.users.list[this.$route.params.user_id]
        // this.user = this.$store.getters['users/findBySlug'](this.workspace.id, this.$route.params.user_id)
      })
    }
  }
}
</script>
