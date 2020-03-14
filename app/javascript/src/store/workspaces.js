import Vue from 'vue/dist/vue.esm'
import axios from '../axios'

import prototype from './prototypes/base'

const state = () => ({
  list: {}
})

const getters = {}

const actions = {
  index({ commit }, _params) {
    return axios
      .get('/workspaces')
      .then((res) => {
        commit('insert', res.data)
      })
      .catch(function(error) {
        console.log(error)
      })
  },
  show({ commit }, params) {
    return axios
      .get('/workspaces/' + params.workspace_id)
      .then((res) => {
        commit('insert', res.data)
      })
      .catch(function(error) {
        console.log(error)
      })
  },
  create({ state, commit }, params) {
    return axios
      .post('/workspaces', params.data)
      .then((res) => {
        commit('insert', res.data)
        return Promise.resolve(state.list[res.data.slug])
      })
      .catch((error) => {
        return Promise.reject(error.response.data)
      })
  },
  update({ state, commit }, params) {
    return axios
      .patch('/workspaces/' + params.workspace_id, params.data)
      .then((res) => {
        commit('modify', { slug: params.workspace_id, data: res.data })
        return Promise.resolve(state.list[res.data.slug])
      })
      .catch((error) => {
        return Promise.reject(error.response.data)
      })
  },
  destroy({ commit }, params) {
    return axios
      .delete('/workspaces/' + params.workspace_id)
      .then((res) => {
        commit('remove', params.workspace_id)
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
      state.list[workspace.slug] = { ...state.list[workspace.slug], ...prototype, ...workspace }
    })
  },
  modify(state, params) {
    state.list[params.data.slug] = { ...state.list[params.slug], ...prototype, ...params.data }
    if (params.slug != params.data.slug) {
      Vue.delete(state.list, params.slug)
    }
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
