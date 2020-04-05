import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex'
Vue.use(Vuex)

import authentication from './authentication'

import workspaces from './workspaces'
import content_types from './content_types'
import content_entries from './content_entries'

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
    content_types,
    content_entries
  }
})

export default store
