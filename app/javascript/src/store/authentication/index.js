import { authAPI as axios } from '../../axios'

import account from './account'

const jwtDecode = require('jwt-decode')

const state = () => ({
  currentSession: {}
})

const actions = {
  login({ state, commit }, payload) {
    return axios
      .post('/login', payload)
      .then((res) => {
        if (res.data.jwt) {
          localStorage.setItem('user-token', res.data.jwt)
        }
        commit('setSession', res.data.jwt)
        return state.currentSession
      })
      .catch((error) => {
        return Promise.reject(error.response.data)
      })
  },
  signup({ state, commit }, payload) {
    return axios
      .post('/signup', payload)
      .then((res) => {
        if (res.data.jwt) {
          localStorage.setItem('user-token', res.data.jwt)
        }
        commit('setSession', res.data.jwt)
        return state.currentSession
      })
      .catch((error) => {
        return Promise.reject(error.response.data)
      })
  },
  confirm({ state, commit }, params) {
    return axios
      .get('/confirm/' + params.confirmation_token)
      .then((res) => {
        if (res.data.jwt) {
          localStorage.setItem('user-token', res.data.jwt)
        }
        commit('setSession', res.data.jwt)
        return state.currentSession
      })
      .catch((error) => {
        return Promise.reject(error.response.data)
      })
  },
  signout({ commit }) {
    return axios
      .delete('/signout')
      .then((res) => {
        localStorage.removeItem('user-token')
        commit('endSession')
      })
      .catch((error) => {
        console.log(error)
      })
  }
}

const mutations = {
  setSession(state, payload) {
    state.currentSession = jwtDecode(payload).data
  },
  endSession(state) {
    state.currentSession = {}
  }
}

const authentication = {
  namespaced: true,
  state,
  actions,
  mutations,
  modules: {
    account
  }
}

export default authentication
