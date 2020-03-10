import Vue from 'vue/dist/vue.esm'
import axios from '../axios'

const state = () => ({
  list: {}
})

const getters = {}

const actions = {
  index({ commit }, params) {
    return axios
      .get('/workspaces/' + params.workspaceId + '/content_types/' + params.content_typeId + '/content_entries')
      .then((res) => {
        commit('insert', res.data)
      })
      .catch(function(error) {
        console.log(error)
      })
  },
  show({ commit }, params) {
    return axios
      .get('/workspaces/' + params.workspaceId + '/content_types/' + params.content_typeId + '/content_entries/' + params.content_entryId) // TODO: Consistent naming
      .then((res) => {
        commit('insert', res.data)
      })
      .catch(function(error) {
        console.log(error)
      })
  },
  create({ commit }, params) {
    return axios
      .post('/workspaces/' + params.workspaceId + '/content_types/' + params.content_typeId + '/content_entries', params.data)
      .then((res) => {
        commit('insert', res.data)
      })
      .catch(function(error) {
        console.log(error)
      })
  },
  update({ commit }, params) {
    return axios
      .patch('/workspaces/' + params.workspaceId + '/content_types/' + params.content_typeId + '/content_entries/' + params.content_entryId, params.data)
      .then((res) => {
        commit('insert', res.data)
      })
      .catch(function(error) {
        console.log(error)
      })
  },
  destroy({ commit }, params) {
    return axios
      .delete('/workspaces/' + params.workspaceId + '/content_types/' + params.content_typeId + '/content_entries/' + params.content_entryId)
      .then((res) => {
        commit('remove', params.content_entryId)
      })
      .catch(function(error) {
        console.log(error)
      })
  }
}

const mutations = {
  insert(state, payload) {
    const isArray = Array.isArray(payload)
    let content_entries = isArray ? payload : [payload]
    content_entries.map((content_entry) => {
      state.list[content_entry.id] = { ...state.list[content_entry.id], ...content_entry }
    })
  },
  remove(state, id) {
    Vue.delete(state.list, id)
  }
}

const content_entries = {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}

export default content_entries
