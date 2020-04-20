import axios from 'axios'

// Default settings
axios.defaults.baseURL = '/admin'
axios.defaults.headers.common['Accept'] = 'application/json'

// Interceptor Functions
const requestInterceptor = (request) => {
  let token = localStorage.getItem('user-token')

  if (token) {
    request.headers['Authorization'] = `Bearer ${ token }`
  }

  return request
}

const responseErrorInterceptor = (error) => {
  if (error.response.status === 401) {
    localStorage.removeItem('user-token')
    window.location = '/login'
  } else {
    return Promise.reject(error)
  }
}

// Axios Instances
const adminAPI = axios.create()
const authAPI = axios.create({
  baseURL: '/auth'
})

adminAPI.interceptors.request.use(
  requestInterceptor,
  (error) => { return Promise.reject(error) }
)

authAPI.interceptors.request.use(
  requestInterceptor,
  (error) => { return Promise.reject(error) }
)

adminAPI.interceptors.response.use(
  (response) => { return response },
  responseErrorInterceptor
)

authAPI.interceptors.response.use(
  (response) => { return response },
  responseErrorInterceptor
)

export default adminAPI

export { authAPI }
