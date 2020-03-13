<template lang="pug">
div
  v-row(v-if="workspace")
    v-col
      workspace-nav(:workspace="workspace")
    v-col(:cols="9")
      h1 Edit Workspace
      workspace-form(:workspace="workspace", :submit="update")
      a(v-on:click.stop="destroy" href="javascript:;") Delete
      router-link(:to="{ name: 'workspace_path', params: { workspace_id: $route.params.workspace_id } }") Back
</template>

<script>
import WorkspaceNav from './_nav.vue'
import WorkspaceForm from './_form.vue'
export default {
  components: {
    WorkspaceNav,
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
      this.$store.dispatch('workspaces/show', { workspace_id: this.$route.params.workspace_id }).then(() => {
        this.workspace = this.$store.state.workspaces.list[this.$route.params.workspace_id]
      })
    },
    update: function () {
      this.$store.dispatch('workspaces/update', { workspace_id: this.$route.params.workspace_id, data: { workspace: this.workspace } }).then(() => {
        this.$router.push('/')
      })
    },
    destroy: function () {
      this.$store.dispatch('workspaces/destroy', { workspace_id: this.$route.params.workspace_id }).then(() => {
        this.$router.push('/')
      })
    }
  }
}
</script>
