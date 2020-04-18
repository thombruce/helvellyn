import store from '../store'

const settings = {
  computed: {
    settings() {
      return store.state.settings.list
    }
  },
  methods: {
    // Called from App.vue to ensure it only runs once.
    fetchSettings () {
      store.dispatch('settings/public')
    }
  }
}

export default settings
