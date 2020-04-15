const jwtDecode = require('jwt-decode')

const session = {
  data: function () {
    return {
      currentSession: null,
      currentUser: null
    }
  },
  created: function () {
    // TODO: This whole mixin needs refactored to use the new store version
    //       of currentSession. But this in particular is the big issue:
    //       Because this is a global mixin, fetchSession will be ran when
    //       EVERY component is created. That's dozens of times per page.
    //       Leaving for now, as it doesn't hit the API, but do fix this.
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
