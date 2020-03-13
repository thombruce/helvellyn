import axios from '../axios'

const state = () => ({
  list: {}
})

const getters = {}

const actions = {
  show({ commit }, id) {
    return axios
      .get('/users/' + id)
      .then((res) => {
        commit('insert', res.data)
      })
      .catch(function(error) {
        console.log(error)
      })
  },
  create({ commit }, payload) {
    return axios
      .post('/users', payload)
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
      .patch('/users/' + payload.id, payload)
      .then((res) => {
        commit('insert', res.data)
      })
      .catch((error) => {
        return Promise.reject(error.response.data)
      })
  },
  destroy({ commit }, id) {
    return axios
      .delete('/users/' + id)
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
      state.list[user.id] = { ...state.list[user.id], ...user }
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
