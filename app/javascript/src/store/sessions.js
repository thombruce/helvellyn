import axios from '../axios'

import prototype from './prototypes/base'

const state = () => ({
  list: {}
})

const getters = {}

const actions = {
  create({ dispatch }, payload) {
    return axios
      .post('/sessions', payload)
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
  destroy({ commit }, id) {
    return axios
      .delete('/sessions/current')
      .then((res) => {
        localStorage.removeItem('user-token')
      })
      .catch((error) => {
        console.log(error)
      })
  }
}

const mutations = {
  insert(state, payload) {
    const isArray = Array.isArray(payload)
    let sessions = isArray ? payload : [payload]
    sessions.map((session) => {
      state.list[session.id] = { ...state.list[session.id], ...prototype, ...session }
    })
  }
}

const sessions = {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}

export default sessions
