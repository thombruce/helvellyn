<template lang="pug">
div
  v-row(v-if="workspace")
    v-col
      h1 Edit Workspace
      workspace-form(:workspace="workspace", :submit="update")
      a(v-on:click.stop="destroy" href="javascript:;") Delete
      router-link(:to="{ name: 'content_types_path', params: { workspace_id: $route.params.workspace_id } }") Back
</template>

<script>
import WorkspaceForm from './_form.vue'
export default {
  components: {
    WorkspaceForm
  },
  data() {
    return {
      workspace: {
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
      this.workspace = null
      this.$store.dispatch('workspaces/show', { workspace_id: this.$route.params.workspace_id }).then(() => {
        this.workspace = this.$store.state.workspaces.list[this.$route.params.workspace_id]
      })
    },
    update: function () {
      this.$store.dispatch('workspaces/update', { workspace_id: this.$route.params.workspace_id, data: { workspace: this.workspace } }).then((res) => {
        this.$router.push({ name: 'content_types_path', params: { workspace_id: res.slug } })
      }).catch((errors) => {
        this.workspace.errors = errors
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
