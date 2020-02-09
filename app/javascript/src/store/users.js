import axios from '../axios'

const state = () => ({
  list: {}
})

const getters = {}

const actions = {
  create({ dispatch }, payload) {
    return axios
      .post('/users', payload)
      .then((res) => {
        return dispatch('add', res.data)
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
