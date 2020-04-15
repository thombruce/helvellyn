<template lang="pug">
div
  v-row(v-if="workspace")
    v-col
      h1 Edit Workspace
      workspace-form(:workspace="workspace", :submit="update")

      v-alert.my-4(
        type="warning"
        colored-border
        border="left"
        elevation="2"
      )
        h4.title API token
        p.body-1 This is your token for accessing the API.
        p.body-2 Be careful when regenerating this; your old token will stop working immediately, and you will be provided a brand new token for accessing the API.
        v-text-field(
          label="Token"
          v-model="workspace.token"
          readonly
          :error-messages="workspace.errors.token"
          :append-icon="showToken ? 'mdi-eye' : 'mdi-eye-off'"
          :type="showToken ? 'text' : 'password'"
          @click:append="showToken = !showToken"
        )
        v-btn(color="warning" @click="regenToken") Regenerate Token

      v-alert.my-4(
        type="error"
        colored-border
        border="left"
        elevation="2"
      )
        h4.title Danger Zone
        p.body-1 Your workspace cannot be restored if deleted. Please be certain this is what you want.
        p.body-2 You will also lose all of the templates and entities associated with this workspace.
        v-dialog(v-model="dialog" persistent max-width="600px")
          template(v-slot:activator="{ on }")
            v-btn(color="error" v-on="on") Delete Workspace
          v-card
            v-card-title
              span(class="headline") Delete this Workspace
            v-card-text
              p.body-2 All of your templates and content entries associated with this workspace will be lost.
              p.body-1 Are you sure you want to delete this workspace?
            v-card-actions
              v-spacer
              v-btn(@click="dialog = false") Cancel
              v-btn(color="error" @click="destroy") Delete Workspace

      router-link(:to="{ name: 'templates_path', params: { workspace_id: $route.params.workspace_id } }") Back
</template>

<script>
import WorkspaceForm from './_form.vue'
export default {
  components: {
    WorkspaceForm
  },
  data() {
    return {
      dialog: false,
      showToken: false,
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
        this.$router.push({ name: 'templates_path', params: { workspace_id: res.slug } })
      }).catch((errors) => {
        this.workspace.errors = errors
      })
    },
    destroy: function () {
      this.$store.dispatch('workspaces/destroy', { workspace_id: this.$route.params.workspace_id }).then(() => {
        this.$router.push('/')
      })
    },
    regenToken: function () {
      this.$store.dispatch('workspaces/token', { workspace_id: this.$route.params.workspace_id }).then(() => {
        this.workspace = this.$store.state.workspaces.list[this.$route.params.workspace_id]
      })
    }
  }
}
</script>
