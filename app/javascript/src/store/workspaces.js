import Vue from 'vue/dist/vue.esm'
import axios from '../axios'

const state = () => ({
  list: {}
})

const getters = {}

const actions = {
  index({ commit }) {
    return axios
      .get('/workspaces')
      .then((res) => {
        commit('insert', res.data)
      })
      .catch(function(error) {
        console.log(error)
      })
  },
  show({ commit }, id) {
    return axios
      .get('/workspaces/' + id)
      .then((res) => {
        commit('insert', res.data)
      })
      .catch(function(error) {
        console.log(error)
      })
  },
  create({ commit }, payload) {
    return axios
      .post('/workspaces', payload)
      .then((res) => {
        commit('insert', res.data)
      })
      .catch(function(error) {
        console.log(error)
      })
  },
  update({ commit }, payload) {
    return axios
      .patch('/workspaces/' + payload.id, payload)
      .then((res) => {
        commit('insert', res.data)
      })
      .catch(function(error) {
        console.log(error)
      })
  },
  destroy({ commit }, id) {
    return axios
      .delete('/workspaces/' + id)
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
    let workspaces = isArray ? payload : [payload]
    workspaces.map((workspace) => {
      state.list[workspace.id] = { ...state.list[workspace.id], ...workspace }
    })
  },
  remove(state, id) {
    Vue.delete(state.list, id)
  }
}

const workspaces = {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}

export default workspaces
