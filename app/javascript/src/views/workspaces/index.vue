<template lang="pug">
div
  h1 Workspaces

  router-link(:to="{ name: 'new_workspace_path' }") New workspace

  v-simple-table(v-if="workspaces")
    thead
      tr
        th Title
        th Actions
    tbody
      tr(v-for="workspace in workspaces")
        td
          router-link(:to="{ name: 'templates_path', params: { workspace_id: workspace.slug } }") {{ workspace.title }}
        td
          router-link.mr-1(:to="{ name: 'templates_path', params: { workspace_id: workspace.slug } }") View
          router-link.mr-1(:to="{ name: 'edit_workspace_path', params: { workspace_id: workspace.slug } }") Edit

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
