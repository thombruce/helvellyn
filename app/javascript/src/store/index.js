import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex'
Vue.use(Vuex)

import users from './users'
import sessions from './sessions'

import workspaces from './workspaces'
import content_types from './content_types'
import content_entries from './content_entries'
import posts from './posts'

const store = new Vuex.Store({
  modules: {
    users,
    sessions,
    workspaces,
    content_types,
    content_entries,
    posts
  }
})

export default store
