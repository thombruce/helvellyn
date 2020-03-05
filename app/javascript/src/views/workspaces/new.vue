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
        title: ''
      }
    }
  },
  methods: {
    create: function () {
      this.$store.dispatch('workspaces/create', { workspace: this.workspace }).then(() => {
        this.$router.push('/')
      })
    }
  }
}
</script>
