import axios from 'axios'

const apiClientMulti = axios.create({
  baseURL: `http://localhost:3000`,
  withCredentials: false, // This is the default
  headers: {
    Accept: 'multipart/form-data',
    'Content-Type': 'multipart/form-data',
    'Access-Control-Allow-Origin': '*',
  },
})
const apiClientJson = axios.create({
  baseURL: `http://localhost:3000`,
  withCredentials: true, // This is the default
  headers: {
    Accept: 'application/json',
    'Content-Type': 'application/json',
  },
})

export default {
  // getEvents() {
  //   return apiClient.get('/events')
  // },
  getBlog(id) {
    return apiClientMulti.get('/blog/' + id)
  },
  createUser(userData) {
    return apiClientMulti.post('/create-user', userData)
  },

  checkCredentials(userData) {
    return apiClientJson.post('/signin/', userData)
  },

  logout() {
    return apiClientJson.get('/logout')
  },

  createBlog(blogData) {
    return apiClientMulti.post('/create-blog', blogData)
  },
}
