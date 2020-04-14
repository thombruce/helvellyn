import store from '../store'

const settings = {
  computed: {
    settings() {
      return store.state.settings.list
    }
  },
  created () {
    this.fetchSettings()
  },
  methods: {
    fetchSettings () {
      store.dispatch('settings/public')
    }
  }
}

export default settings
