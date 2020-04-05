import users from './users'
import sessions from './sessions'

const actions = {
  login({ dispatch }, payload) { // A shortcut for...
    return dispatch('sessions/create', payload)
  },
  signup({ dispatch }, payload) { // A shortcut for...
    return dispatch('users/create', payload)
  },
  signout({ dispatch }) { // A shortcut for...
    return dispatch('sessions/destroy')
  }
}

const authentication = {
  namespaced: true,
  actions,
  modules: {
    users,
    sessions
  }
}

export default authentication
