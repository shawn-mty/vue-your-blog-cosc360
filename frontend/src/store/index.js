import Vue from 'vue'
import Vuex from 'vuex'
import Cookies from 'universal-cookie'

const cookies = new Cookies()
Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    currentUser: {
      id: '',
      username: '',
      isSignedIn: false,
      profileImageURL: '',
    },
  },
  mutations: {
    setCurrentUser(state, userData) {
      state.currentUser = userData

      cookies.set('userData', userData)
    },
  },
  actions: {},
  modules: {},
  getters: {
    getCurrentUserData: state => {
      if (cookies.get('userData')) state.currentUser = cookies.get('userData')
      return state.currentUser
    },
  },
})
