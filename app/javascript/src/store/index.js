import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex'
Vue.use(Vuex)

import users from './users'
import sessions from './sessions'
import posts from './posts'

const store = new Vuex.Store({
  modules: {
    users,
    sessions,
    posts
  }
})

export default store
