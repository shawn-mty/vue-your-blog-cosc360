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

const apiClientJson = axios.create({
  baseURL: `http://localhost:3000`,
  withCredentials: false, // This is the default
  headers: {
    Accept: 'application/json',
    'Content-Type': 'application/json',
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
    return apiClient.post('/user', userData)
  },

  fetchUser(userData) {
    return apiClientJson.post('/signin/', userData)
  },
}
