import axios from '../axios'

import prototype from './prototypes/base'

const state = () => ({
  list: {}
})

const getters = {
  forWorkspace: (state, getters, rootState) => (workspace_id) => {
    return rootState.workspaces.list[workspace_id].users
  }
}

const actions = {
  index({ commit }, params) {
    return axios
      .get('/workspaces/' + params.workspace_id + '/users')
      .then((res) => {
        commit('insert', res.data)
        commit('workspaces/addUsers', {workspace_id: params.workspace_id, users: res.data}, { root: true }) // TODO: IDs only
      })
      .catch(function(error) {
        console.log(error)
      })
  },
  show({ commit }, params) {
    return axios
      .get('/workspaces/' + params.workspace_id + '/users/' + params.user_id)
      .then((res) => {
        commit('insert', res.data)
      })
      .catch(function(error) {
        console.log(error)
      })
  },
  invite({ state, commit }, params) {
    return axios
      .post('/workspaces/' + params.workspace_id + '/users/invite', params.data)
      .then((res) => {
        commit('insert', res.data)
      })
      .catch((error) => {
        console.log(error)
      })
  },
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
