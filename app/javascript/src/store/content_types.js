import Vue from 'vue/dist/vue.esm'
import axios from '../axios'

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
      .catch(function(error) {
        console.log(error)
      })
  },
  update({ commit }, params) {
    return axios
      .patch('/workspaces/' + params.workspace_id + '/content_types/' + params.content_type_id, params.data)
      .then((res) => {
        commit('insert', res.data)
      })
      .catch(function(error) {
        console.log(error)
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
      state.list[content_type.slug] = { ...state.list[content_type.slug], ...content_type }
      // TODO: Use of slug as key means editing slug causes duplication
      //       Update action should be aware of which item it's editing.
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
