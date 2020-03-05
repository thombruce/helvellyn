import Vue from 'vue/dist/vue.esm'
import axios from '../axios'

const state = () => ({
  list: {}
})

const getters = {}

const actions = {
  index({ commit }, workspaceId) {
    return axios
      .get('/workspaces/' + workspaceId + '/posts')
      .then((res) => {
        commit('insert', res.data)
      })
      .catch(function(error) {
        console.log(error)
      })
  },
  show({ commit }, id) {
    return axios
      .get('/posts/' + id)
      .then((res) => {
        commit('insert', res.data)
      })
      .catch(function(error) {
        console.log(error)
      })
  },
  create({ commit }, payload) {
    return axios
      .post('/workspaces/' + payload.workspaceId + '/posts', payload.data)
      .then((res) => {
        commit('insert', res.data)
      })
      .catch(function(error) {
        console.log(error)
      })
  },
  update({ commit }, payload) {
    return axios
      .patch('/posts/' + payload.id, payload)
      .then((res) => {
        commit('insert', res.data)
      })
      .catch(function(error) {
        console.log(error)
      })
  },
  destroy({ commit }, id) {
    return axios
      .delete('/posts/' + id)
      .then((res) => {
        commit('remove', id)
      })
      .catch(function(error) {
        console.log(error)
      })
  }
}

const mutations = {
  insert(state, payload) {
    const isArray = Array.isArray(payload)
    let posts = isArray ? payload : [payload]
    posts.map((post) => {
      state.list[post.id] = { ...state.list[post.id], ...post }
    })
  },
  remove(state, id) {
    Vue.delete(state.list, id)
  }
}

const posts = {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}

export default posts
