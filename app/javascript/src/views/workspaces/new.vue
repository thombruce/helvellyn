<template lang="pug">
div
  h1 New Workspace
  workspace-form(:workspace="workspace" :submit="create")
  router-link(:to="{ name: 'workspaces_path' }") Back
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
        title: '',
        errors: []
      }
    }
  },
  methods: {
    create: function () {
      this.$store.dispatch('workspaces/create', { data: { workspace: this.workspace } }).then((res) => {
        this.$router.push({ name: 'content_types_path', params: { workspace_id: res.slug } })
      }).catch((errors) => {
        this.workspace.errors = errors
      })
    }
  }
}
</script>
