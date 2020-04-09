import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex'
Vue.use(Vuex)

import authentication from './authentication'

import workspaces from './workspaces'
import users from './users'
import templates from './templates'
import entities from './entities'

const actions = {
  login({ dispatch }, payload) { // A shortcut for...
    return dispatch('authentication/login', payload)
  },
  signup({ dispatch }, payload) { // A shortcut for...
    return dispatch('authentication/signup', payload)
  },
  signout({ dispatch }) { // A shortcut for...
    return dispatch('authentication/signout')
  }
}

const store = new Vuex.Store({
  actions,
  modules: {
    authentication,
    workspaces,
    users,
    templates,
    entities
  }
})

export default store
