import Vue from 'vue/dist/vue.esm'
import axios from '../axios'

import prototype from './prototypes/base'

const state = () => ({
  list: {}
})

const getters = {
  forTemplate: (state) => (template_id) => {
    return Object.values(state.list).filter(entity => entity.template_id === template_id)

    // NOTE: The below uses the same approach but returns an Object, rather than an Array.
    //       I don't know that there's any reason an Array won't do.

    // let entriesForTemplate = {}
    // Object.values(state.list)
    //       .filter(entity => entity.template_id === template_id)
    //       .forEach((entity) => {
    //         entriesForTemplate[entity.slug] = { ...prototype, ...entity }
    //       })
    // return entriesForTemplate
  },
  findBySlug: (state) => (template_id, slug) => {
    // TODO: This would do better to allow a hash of params and inclusively use them in the find function below.
    return Object.values(state.list).find(
      entity => (entity.template_id === template_id) && (entity.slug === slug)
    )
  }
}

const actions = {
  index({ commit }, params) {
    return axios
      .get('/workspaces/' + params.workspace_id + '/templates/' + params.template_id + '/entities')
      .then((res) => {
        commit('insert', res.data)
      })
      .catch(function(error) {
        console.log(error)
      })
  },
  show({ commit }, params) {
    return axios
      .get('/workspaces/' + params.workspace_id + '/templates/' + params.template_id + '/entities/' + params.entity_id)
      .then((res) => {
        commit('insert', res.data)
      })
      .catch(function(error) {
        console.log(error)
      })
  },
  create({ state, commit }, params) {
    return axios
      .post('/workspaces/' + params.workspace_id + '/templates/' + params.template_id + '/entities', params.data)
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
      .patch('/workspaces/' + params.workspace_id + '/templates/' + params.template_id + '/entities/' + params.entity_id, params.data)
      .then((res) => {
        commit('modify', { slug: params.entity_id, data: res.data })
        return Promise.resolve(state.list[res.data.slug])
      })
      .catch((error) => {
        return Promise.reject(error.response.data)
      })
  },
  destroy({ commit }, params) {
    return axios
      .delete('/workspaces/' + params.workspace_id + '/templates/' + params.template_id + '/entities/' + params.entity_id)
      .then((res) => {
        commit('remove', params.entity_id)
      })
      .catch(function(error) {
        console.log(error)
      })
  }
}

const mutations = {
  insert(state, payload) {
    const isArray = Array.isArray(payload)
    let entities = isArray ? payload : [payload]
    entities.map((entity) => {
      state.list[entity.slug] = { ...state.list[entity.slug], ...prototype, ...entity }
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

const entities = {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}

export default entities
