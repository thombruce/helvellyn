import users from './users'
import sessions from './sessions'

const authentication = {
  namespaced: true,
  modules: {
    users,
    sessions
  }
}

export default authentication
