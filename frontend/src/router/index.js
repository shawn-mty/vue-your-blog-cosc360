import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../views/Home.vue'
import Register from '../views/Register.vue'
import MakeABlog from '../views/MakeABlog.vue'
import ShowBlog from '../views/ShowBlog.vue'
import SignIn from '../views/SignIn.vue'
import Profile from '../views/Profile.vue'
import Admin from '../views/Admin.vue'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home,
  },
  {
    path: '/register',
    name: 'Register',
    component: Register,
  },
  {
    path: '/signin',
    name: 'SignIn',
    component: SignIn,
  },
  {
    path: '/profile',
    name: 'Profile',
    component: Profile,
  },
  {
    path: '/admin',
    name: 'Admin',
    component: Admin,
  },
  {
    path: '/make-a-blog',
    name: 'MakeABlog',
    component: MakeABlog,
  },
  {
    path: '/blog/:id',
    name: 'show-blog',
    component: ShowBlog,
    props: true,
  },
]

const router = new VueRouter({
  routes,
})

export default router
