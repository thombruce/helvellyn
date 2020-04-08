import axios from 'axios'

// Default settings
axios.defaults.baseURL = '/admin'
axios.defaults.headers.common['Accept'] = 'application/json'

// Interceptor Functions
const interceptor = (config) => {
  let token = localStorage.getItem('user-token')

  if (token) {
    config.headers['Authorization'] = `Bearer ${ token }`
  }

  return config
}

const interceptorError = (error) => {
  return Promise.reject(error)
}

// Axios Instances
const adminAPI = axios.create()
const authAPI = axios.create({
  baseURL: '/auth'
})

adminAPI.interceptors.request.use(
  interceptor, 
  interceptorError
)

authAPI.interceptors.request.use(
  interceptor, 
  interceptorError
)

export default adminAPI

export { authAPI }
