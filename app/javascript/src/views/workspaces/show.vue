<template lang="pug">
div
  v-row(v-if="workspace")
    v-col
      workspace-nav(:workspace="workspace")
    v-col(:cols="9")
      router-view(:workspace="workspace")
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
      this.$store.dispatch('workspaces/show', this.$route.params.workspace_id).then(() => {
        this.workspace = this.$store.state.workspaces.list[this.$route.params.workspace_id]
      })
    }
  }
}
</script>
