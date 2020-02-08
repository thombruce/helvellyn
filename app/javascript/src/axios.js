import axios from 'axios'

axios.defaults.headers.common['Accept'] = 'application/json'

const loggedIn = localStorage.getItem('user-token')
if (loggedIn) {
  axios.defaults.headers.common['Authorization'] = JSON.parse(loggedIn)
}

export default axios
