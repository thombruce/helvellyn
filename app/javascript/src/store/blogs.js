import Vue from 'vue/dist/vue.esm'
import axios from '../axios'

const state = () => ({
  list: {}
})

const getters = {}

const actions = {
  index({ commit }) {
    return axios
      .get('/blogs')
      .then((res) => {
        commit('insert', res.data)
      })
      .catch(function(error) {
        console.log(error)
      })
  },
  show({ commit }, id) {
    return axios
      .get('/blogs/' + id)
      .then((res) => {
        commit('insert', res.data)
      })
      .catch(function(error) {
        console.log(error)
      })
  },
  create({ commit }, payload) {
    return axios
      .post('/blogs', payload)
      .then((res) => {
        commit('insert', res.data)
      })
      .catch(function(error) {
        console.log(error)
      })
  },
  update({ commit }, payload) {
    return axios
      .patch('/blogs/' + payload.id, payload)
      .then((res) => {
        commit('insert', res.data)
      })
      .catch(function(error) {
        console.log(error)
      })
  },
  destroy({ commit }, id) {
    return axios
      .delete('/blogs/' + id)
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
    let blogs = isArray ? payload : [payload]
    blogs.map((blog) => {
      state.list[blog.id] = { ...state.list[blog.id], ...blog }
    })
  },
  remove(state, id) {
    Vue.delete(state.list, id)
  }
}

const blogs = {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}

export default blogs
