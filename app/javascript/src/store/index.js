import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex'
Vue.use(Vuex)

import users from './users'
import sessions from './sessions'

import blogs from './blogs'
import posts from './posts'

const store = new Vuex.Store({
  modules: {
    users,
    sessions,
    blogs,
    posts
  }
})

export default store
