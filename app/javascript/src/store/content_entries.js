import Vue from 'vue/dist/vue.esm'
import axios from '../axios'

const state = () => ({
  list: {}
})

const getters = {}

const actions = {
  index({ commit }, params) {
    return axios
      .get('/workspaces/' + params.workspace_id + '/content_types/' + params.content_type_id + '/content_entries')
      .then((res) => {
        commit('insert', res.data)
      })
      .catch(function(error) {
        console.log(error)
      })
  },
  show({ commit }, params) {
    return axios
      .get('/workspaces/' + params.workspace_id + '/content_types/' + params.content_type_id + '/content_entries/' + params.content_entry_id)
      .then((res) => {
        commit('insert', res.data)
      })
      .catch(function(error) {
        console.log(error)
      })
  },
  create({ commit }, params) {
    return axios
      .post('/workspaces/' + params.workspace_id + '/content_types/' + params.content_type_id + '/content_entries', params.data)
      .then((res) => {
        commit('insert', res.data)
      })
      .catch(function(error) {
        console.log(error)
      })
  },
  update({ commit }, params) {
    return axios
      .patch('/workspaces/' + params.workspace_id + '/content_types/' + params.content_type_id + '/content_entries/' + params.content_entry_id, params.data)
      .then((res) => {
        commit('insert', res.data)
      })
      .catch(function(error) {
        console.log(error)
      })
  },
  destroy({ commit }, params) {
    return axios
      .delete('/workspaces/' + params.workspace_id + '/content_types/' + params.content_type_id + '/content_entries/' + params.content_entry_id)
      .then((res) => {
        commit('remove', params.content_entry_id)
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
