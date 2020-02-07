import axios from 'axios'

const state = () => ({
  list: {}
})

const getters = {}

const actions = {
  create({ dispatch }, payload) {
    return axios
      .post('/sessions', payload)
      .then((res) => {
        console.log(res.data)
      })
      .catch(function(error) {
        console.log(error)
      })
  }
}

const mutations = {
  insert(state, payload) {
    payload.map((session) => {
      state.list[session.id] = { ...state.list[session.id], ...item }
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
