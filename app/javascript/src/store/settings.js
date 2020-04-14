import axios from '../axios'

import prototype from './prototypes/base'

const state = () => ({
  list: {}
})

const getters = {}

const actions = {
  show({ commit }) {
    return axios
      .get('/settings')
      .then((res) => {
        commit('insert', res.data)
      })
      .catch(function(error) {
        console.log(error)
      })
  },
  public({ commit }) {
    return axios
      .get('/settings/public')
      .then((res) => {
        commit('insert', res.data)
      })
      .catch(function(error) {
        console.log(error)
      })
  },
  update({ state, commit }, params) {
    return axios
      .patch('/settings', params.data)
      .then((res) => {
        commit('insert', res.data)
        return Promise.resolve(state.list)
      })
      .catch((error) => {
        return Promise.reject(error.response.data)
      })
  }
}

const mutations = {
  insert(state, payload) {
    state.list = { ...state.list, ...prototype, ...payload }
  }
}

const settings = {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}

export default settings
