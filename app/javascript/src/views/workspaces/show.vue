<template lang="pug">
div
  v-row(v-if="workspace")
    v-col
      router-view(:workspace="workspace")
</template>

<script>
export default {
  data () {
    return {
      workspace: null
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
      this.workspace = null
      this.$store.dispatch('workspaces/show', { workspace_id: this.$route.params.workspace_id }).then(() => {
        this.workspace = this.$store.state.workspaces.list[this.$route.params.workspace_id]
        if (!this.workspace.permissions.view_workspace) {
          this.$router.replace({ name: 'root_path' })
        }
      })
    }
  }
}
</script>
