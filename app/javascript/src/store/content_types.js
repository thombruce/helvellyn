import Vue from 'vue/dist/vue.esm'
import axios from '../axios'

const state = () => ({
  list: {}
})

const getters = {}

const actions = {
  index({ commit }, workspaceId) {
    return axios
      .get('/workspaces/' + workspaceId + '/content_types')
      .then((res) => {
        commit('insert', res.data)
      })
      .catch(function(error) {
        console.log(error)
      })
  },
  show({ commit }, id) {
    return axios
      .get('/content_types/' + id)
      .then((res) => {
        commit('insert', res.data)
      })
      .catch(function(error) {
        console.log(error)
      })
  },
  create({ commit }, payload) {
    return axios
      .post('/workspaces/' + payload.workspaceId + '/content_types', payload.data)
      .then((res) => {
        commit('insert', res.data)
      })
      .catch(function(error) {
        console.log(error)
      })
  },
  update({ commit }, payload) {
    return axios
      .patch('/content_types/' + payload.id, payload)
      .then((res) => {
        commit('insert', res.data)
      })
      .catch(function(error) {
        console.log(error)
      })
  },
  destroy({ commit }, id) {
    return axios
      .delete('/content_types/' + id)
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
    let content_types = isArray ? payload : [payload]
    content_types.map((content_type) => {
      state.list[content_type.id] = { ...state.list[content_type.id], ...content_type }
    })
  },
  remove(state, id) {
    Vue.delete(state.list, id)
  }
}

const content_types = {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}

export default content_types
