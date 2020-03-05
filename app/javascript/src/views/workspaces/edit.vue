<template lang="pug">
div
  h1 Edit Workspace
  workspace-form(v-if="workspace" :workspace="workspace", :submit="update")
  a(v-on:click.stop="destroy" href="javascript:;") Delete
  router-link(:to="{ name: 'workspace_path' }") Back
</template>

<script>
import WorkspaceForm from './_form.vue'
export default {
  components: {
    WorkspaceForm
  },
  data() {
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
    },
    update: function () {
      this.$store.dispatch('workspaces/update', { id: this.workspace.id, workspace: this.workspace }).then(() => {
        this.$router.push('/')
      })
    },
    destroy: function () {
      this.$store.dispatch('workspaces/destroy', this.workspace.id).then(() => {
        this.$router.push('/')
      })
    }
  }
}
</script>
