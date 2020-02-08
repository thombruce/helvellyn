export function authHeader() {
  // return authorization header with jwt token
  let jwt = JSON.parse(localStorage.getItem('user-token'))

  if (jwt) {
    return { 'Authorization': 'Bearer ' + jwt }
  } else {
    return {}
  }
}
