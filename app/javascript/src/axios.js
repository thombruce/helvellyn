import axios from 'axios'

axios.defaults.baseURL = '/api'
axios.defaults.headers.common['Accept'] = 'application/json'

axios.interceptors.request.use(
  (config) => {
    let token = localStorage.getItem('user-token')

    if (token) {
      config.headers['Authorization'] = `Bearer ${ token }`
    }

    return config
  }, 

  (error) => {
    return Promise.reject(error)
  }
)

export default axios
