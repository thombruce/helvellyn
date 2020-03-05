import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex'
Vue.use(Vuex)

import users from './users'
import sessions from './sessions'

import workspaces from './workspaces'
import posts from './posts'

const store = new Vuex.Store({
  modules: {
    users,
    sessions,
    workspaces,
    posts
  }
})

export default store
