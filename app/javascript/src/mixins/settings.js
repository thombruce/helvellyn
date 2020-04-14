import axios from '../axios'

const settings = {
  data () {
    return {
      settings: null
    }
  },
  created () {
    this.fetchSettings()
  },
  methods: {
    fetchSettings () {
      axios.get('/settings/public')
        .then((res) => {
          this.settings = res.data
        })
        .catch(function(error) {
          console.log(error)
        })
    }
  }
}

export default settings
