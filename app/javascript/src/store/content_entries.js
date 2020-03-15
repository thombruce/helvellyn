import Vue from 'vue/dist/vue.esm'
import axios from '../axios'

import prototype from './prototypes/base'

const state = () => ({
  list: {}
})

const getters = {
  forContentType: (state) => (content_type_id) => {
    return Object.values(state.list).filter(content_entry => content_entry.content_type_id === content_type_id)

    // NOTE: The below uses the same approach but returns an Object, rather than an Array.
    //       I don't know that there's any reason an Array won't do.

    // let entriesForContentType = {}
    // Object.values(state.list)
    //       .filter(content_entry => content_entry.content_type_id === content_type_id)
    //       .forEach((content_entry) => {
    //         entriesForContentType[content_entry.slug] = { ...prototype, ...content_entry }
    //       })
    // return entriesForContentType
  },
  findBySlug: (state) => (content_type_id, slug) => {
    // TODO: This would do better to allow a hash of params and inclusively use them in the find function below.
    return Object.values(state.list).find(
      content_entry => (content_entry.content_type_id === content_type_id) && (content_entry.slug === slug)
    )
  }
}

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
  create({ state, commit }, params) {
    return axios
      .post('/workspaces/' + params.workspace_id + '/content_types/' + params.content_type_id + '/content_entries', params.data)
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
      .patch('/workspaces/' + params.workspace_id + '/content_types/' + params.content_type_id + '/content_entries/' + params.content_entry_id, params.data)
      .then((res) => {
        commit('modify', { slug: params.content_entry_id, data: res.data })
        return Promise.resolve(state.list[res.data.slug])
      })
      .catch((error) => {
        return Promise.reject(error.response.data)
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
      state.list[content_entry.slug] = { ...state.list[content_entry.slug], ...prototype, ...content_entry }
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

const content_entries = {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}

export default content_entries
