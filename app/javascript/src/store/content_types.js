import Vue from 'vue/dist/vue.esm'
import axios from '../axios'

import prototype from './prototypes/base'

const state = () => ({
  list: {}
})

const getters = {}

const actions = {
  index({ commit }, params) {
    return axios
      .get('/workspaces/' + params.workspace_id + '/content_types')
      .then((res) => {
        commit('insert', res.data)
      })
      .catch(function(error) {
        console.log(error)
      })
  },
  show({ commit }, params) {
    return axios
      .get('/workspaces/' + params.workspace_id + '/content_types/' + params.content_type_id)
      .then((res) => {
        commit('insert', res.data)
      })
      .catch(function(error) {
        console.log(error)
      })
  },
  create({ commit }, params) {
    return axios
      .post('/workspaces/' + params.workspace_id + '/content_types', params.data)
      .then((res) => {
        commit('insert', res.data)
      })
      .catch((error) => {
        return Promise.reject(error.response.data)
      })
  },
  update({ commit }, params) {
    return axios
      .patch('/workspaces/' + params.workspace_id + '/content_types/' + params.content_type_id, params.data)
      .then((res) => {
        commit('modify', { slug: params.content_type_id, data: res.data })
      })
      .catch((error) => {
        return Promise.reject(error.response.data)
      })
  },
  destroy({ commit }, params) {
    return axios
      .delete('/workspaces/' + params.workspace_id + '/content_types/' + params.content_type_id)
      .then((res) => {
        commit('remove', params.content_type_id)
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
      state.list[content_type.slug] = { ...state.list[content_type.slug], ...prototype, ...content_type }
    })
  },
  modify(state, params) {
    state.list[params.data.slug] = { ...state.list[params.slug], ...prototype, ...params.data }
    if (params.slug != params.data.slug) {
      Vue.delete(state.list, params.slug)
    }
  },
  remove(state, slug) {
    Vue.delete(state.list, slug)
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
