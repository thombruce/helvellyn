<template lang="pug">
div
  h1 Workspaces

  router-link(:to="{ name: 'new_workspace_path' }") New workspace

  table.table(v-if="workspaces")
    thead.thead-dark
      tr
        th Title
        th Content
        th Actions
    tbody
      tr(v-for="workspace in workspaces")
        td
          router-link(:to="{ name: 'workspace_path', params: { workspaceId: workspace.id } }") {{ workspace.title }}
        td(v-html="workspace.content")
        td
          router-link.mr-1(:to="{ name: 'workspace_path', params: { workspaceId: workspace.id } }") View
          router-link.mr-1(:to="{ name: 'edit_workspace_path', params: { workspaceId: workspace.id } }") Edit

  p.lead.text-center(v-else) No items to show.
</template>

<script>
export default {
  data () {
    return {
      workspaces: null
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
      this.workspaces = null
      this.$store.dispatch('workspaces/index').then(() => {
        this.workspaces = this.$store.state.workspaces.list
      })
    }
  }
}
</script>
