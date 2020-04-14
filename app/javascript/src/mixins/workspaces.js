const workspaces = {
  data () {
    return {
      workspaces: null,
      currentWorkspace: null
    }
  },
  created () {
    this.fetchWorkspaces()
  },
  methods: {
    fetchWorkspaces () {
      this.$store.dispatch('workspaces/index').then(() => {
        this.workspaces = this.$store.state.workspaces.list
        this.currentWorkspace = this.workspaces[this.$route.params.workspace_id]
      })
    }
  }
}

export default workspaces
