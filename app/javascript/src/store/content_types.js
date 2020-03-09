import Vue from 'vue/dist/vue.esm'
import axios from '../axios'

const state = () => ({
  list: {}
})

const getters = {}

const actions = {
  index({ commit }, params) {
    return axios
      .get('/workspaces/' + params.workspaceId + '/content_types')
      .then((res) => {
        commit('insert', res.data)
      })
      .catch(function(error) {
        console.log(error)
      })
  },
  show({ commit }, params) {
    return axios
      .get('/workspaces/' + params.workspaceId + '/content_types/' + params.content_typeId) // TODO: Consistent naming
      .then((res) => {
        commit('insert', res.data)
      })
      .catch(function(error) {
        console.log(error)
      })
  },
  create({ commit }, params) {
    return axios
      .post('/workspaces/' + params.workspaceId + '/content_types', params.data)
      .then((res) => {
        commit('insert', res.data)
      })
      .catch(function(error) {
        console.log(error)
      })
  },
  update({ commit }, params) {
    return axios
      .patch('/workspaces/' + params.workspaceId + '/content_types/' + params.content_typeId, params.data)
      .then((res) => {
        commit('insert', res.data)
      })
      .catch(function(error) {
        console.log(error)
      })
  },
  destroy({ commit }, params) {
    return axios
      .delete('/workspaces/' + params.workspaceId + '/content_types/' + params.content_typeId)
      .then((res) => {
        commit('remove', params.content_typeId)
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
