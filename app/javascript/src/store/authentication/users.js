import { authAPI as axios } from '../../axios'

import prototype from '../prototypes/base'

const state = () => ({
  list: {}
})

const getters = {}

const actions = {
  show({ commit }, id) {
    return axios
      .get('/account')
      .then((res) => {
        commit('insert', res.data)
      })
      .catch(function(error) {
        console.log(error)
      })
  },
  create({ commit }, payload) {
    return axios
      .post('/signup', payload)
      .then((res) => {
        if (res.data.jwt) {
          localStorage.setItem('user-token', res.data.jwt)
        }
        commit('insert', res.data)
      })
      .catch((error) => {
        return Promise.reject(error.response.data)
      })
  },
  update({ commit }, payload) {
    return axios
      .patch('/account', payload)
      .then((res) => {
        commit('insert', res.data)
      })
      .catch((error) => {
        return Promise.reject(error.response.data)
      })
  },
  destroy({ commit }, id) {
    return axios
      .delete('/account')
      .then((res) => {
        localStorage.removeItem('user-token')
        commit('remove', id)
      })
      .catch(function(error) {
        console.log(error)
      })
  }
}

const mutations = {
  insert(state, payload) {
    const isArray = Array.isArray(payload)
    let users = isArray ? payload : [payload]
    users.map((user) => {
      state.list[user.id] = { ...state.list[user.id], ...prototype, ...user }
    })
  },
  remove(state, id) {
    Vue.delete(state.list, id)
  }
}

const users = {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}

export default users
