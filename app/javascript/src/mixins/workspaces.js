const workspaces = {
  data () {
    return {
      workspaces: null,
      currentWorkspace: null
    }
  },
  created () {
    this.fetchData()
  },
  watch: {
    $route(to, from) {
      this.fetchData()
    }
  },
  methods: {
    fetchData () {
      this.workspaces = null
      this.$store.dispatch('workspaces/index').then(() => {
        this.workspaces = this.$store.state.workspaces.list
        this.currentWorkspace = this.workspaces[this.$route.params.workspaceId]
      })
    }
  }
}

export default workspaces
