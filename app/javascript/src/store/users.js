import axios from '../axios'

const state = () => ({
  list: {}
})

const getters = {}

const actions = {
  create({ commit }, payload) {
    return axios
      .post('/users', payload)
      .then((res) => {
        commit('insert', res.data) // Needs to initiate session.
      })
      .catch(function(error) {
        console.log(error)
      })
  }
}

const mutations = {
  insert(state, payload) {
    payload.map((user) => {
      state.list[user.id] = { ...state.list[user.id], ...item }
    })
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
