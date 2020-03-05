<template lang="pug">
div
  div(v-if="workspace")
    h1(v-html="workspace.title")
    p(v-html="workspace.content")
    router-link(:to="{ name: 'edit_workspace_path', params: { workspaceId: workspace.id } }") Edit
    router-view
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
      this.$store.dispatch('workspaces/show', this.$route.params.workspaceId).then(() => {
        this.workspace = this.$store.state.workspaces.list[this.$route.params.workspaceId]
      })
    }
  }
}
</script>
