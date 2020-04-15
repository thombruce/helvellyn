import { authAPI as axios } from '../../axios'

import prototype from '../prototypes/base'

const state = () => ({
  info: {}
})

const getters = {}

const actions = {
  show({ state, commit }) {
    return axios
      .get('/account')
      .then((res) => {
        commit('insert', res.data)
        return state.info
      })
      .catch(function(error) {
        console.log(error)
      })
  },
  update({ commit }, payload) {
    return axios
      .patch('/account', payload)
      .then((res) => {
        commit('insert', res.data)
        return state.info
      })
      .catch((error) => {
        return Promise.reject(error.response.data)
      })
  },
  destroy({ commit }) {
    return axios
      .delete('/account')
      .then((res) => {
        localStorage.removeItem('user-token')
        commit('remove')
      })
      .catch(function(error) {
        console.log(error)
      })
  }
}

const mutations = {
  insert(state, payload) {
    state.info = { ...state.info, ...prototype, ...payload }
  },
  remove(state, id) {
    state.info = {}
  }
}

const account = {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}

export default account
