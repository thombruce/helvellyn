import Vue from 'vue/dist/vue.esm'
import axios from '../axios'

import prototype from './prototypes/base'

const state = () => ({
  list: {}
})

const getters = {
  forWorkspace: (state) => (workspace_id) => {
    return Object.values(state.list).filter(template => template.workspace_id === workspace_id)
  },
  findBySlug: (state) => (workspace_id, slug) => {
    // TODO: This would do better to allow a hash of params and inclusively use them in the find function below.
    return Object.values(state.list).find(
      template => (template.workspace_id === workspace_id) && (template.slug === slug)
    )
  }
}

const actions = {
  index({ commit }, params) {
    return axios
      .get('/workspaces/' + params.workspace_id + '/templates')
      .then((res) => {
        commit('insert', res.data)
      })
      .catch(function(error) {
        console.log(error)
      })
  },
  show({ commit }, params) {
    return axios
      .get('/workspaces/' + params.workspace_id + '/templates/' + params.template_id)
      .then((res) => {
        commit('insert', res.data)
      })
      .catch(function(error) {
        console.log(error)
      })
  },
  create({ state, commit }, params) {
    return axios
      .post('/workspaces/' + params.workspace_id + '/templates', params.data)
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
      .patch('/workspaces/' + params.workspace_id + '/templates/' + params.template_id, params.data)
      .then((res) => {
        commit('modify', { slug: params.template_id, data: res.data })
        return Promise.resolve(state.list[res.data.slug])
      })
      .catch((error) => {
        return Promise.reject(error.response.data)
      })
  },
  destroy({ commit }, params) {
    return axios
      .delete('/workspaces/' + params.workspace_id + '/templates/' + params.template_id)
      .then((res) => {
        commit('remove', params.template_id)
      })
      .catch(function(error) {
        console.log(error)
      })
  }
}

const mutations = {
  insert(state, payload) {
    const isArray = Array.isArray(payload)
    let templates = isArray ? payload : [payload]
    templates.map((template) => {
      state.list[template.slug] = { ...state.list[template.slug], ...prototype, ...template }
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

const templates = {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}

export default templates
