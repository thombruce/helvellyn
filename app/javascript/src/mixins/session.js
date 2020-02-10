const jwtDecode = require('jwt-decode')

const session = {
  data: function () {
    return {
      currentSession: null,
      currentUser: null
    }
  },
  created: function () {
    this.fetchSession()
  },
  methods: {
    fetchSession: function () {
      var token = localStorage.getItem('user-token')
      if (token) {
        this.currentSession = jwtDecode(token).data
        this.currentUser = this.currentSession.user
      }
    }
  }
}

export default session
