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
    searchInput: '',
  },
  mutations: {
    setCurrentUser(state, userData) {
      state.currentUser = userData
      cookies.set('userData', userData)
    },
    setSearchInput(state, searchInput) {
      state.searchInput = searchInput
    },
  },
  actions: {},
  modules: {},
  getters: {
    getCurrentUserData: state => {
      if (cookies.get('userData')) state.currentUser = cookies.get('userData')
      return state.currentUser
    },
    getSearchInput: state => {
      if (state.searchInput) {
        return state.searchInput
      }
    },
  },
})
