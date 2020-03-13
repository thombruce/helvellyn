import axios from '../axios'

const state = () => ({
  list: {}
})

const getters = {}

const actions = {
  create({ dispatch }, payload) {
    return axios
      .post('/sessions', payload)
      .then((res) => {
        localStorage.setItem('user-token', res.data.jwt)
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

const mutations = {}

const sessions = {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}

export default sessions
