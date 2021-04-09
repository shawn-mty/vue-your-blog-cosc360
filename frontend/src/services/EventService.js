import axios from 'axios'

const apiClient = axios.create({
  baseURL: `http://localhost:3000`,
  withCredentials: false, // This is the default
  headers: {
    Accept: 'multipart/form-data',
    'Content-Type': 'multipart/form-data',
    'Access-Control-Allow-Origin': '*',
  },
})

export default {
  // getEvents() {
  //   return apiClient.get('/events')
  // },
  // getEvent(id) {
  //   return apiClient.get('/events/' + id)
  // },
  createUser(userData) {
    return apiClient.post('/create-user', userData)
  },
  createBlog(blogData) {
    return apiClient.post('/create-blog', blogData)
  },
}
