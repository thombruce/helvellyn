<template lang="pug">
div
  v-row(v-if="workspace")
    v-col
      workspace-nav(:workspace="workspace")
    v-col(:cols="9")
      h1(v-html="workspace.title")
      p(v-html="workspace.content")
      router-link(:to="{ name: 'edit_workspace_path', params: { workspaceId: workspace.id } }") Edit
      router-view
</template>

<script>
import WorkspaceNav from './_nav.vue'
export default {
  components: {
    WorkspaceNav
  },
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
