import Vue from 'vue/dist/vue.esm'
import VueRouter from 'vue-router'
Vue.use(VueRouter)

import SessionNew from './views/sessions/new.vue'

import UserShow from './views/users/show.vue'
import UserNew from './views/users/new.vue'
import UserEdit from './views/users/edit.vue'

const router = new VueRouter({
  mode: 'history',
  routes: [
    { path: '/', component: SessionNew, name: 'root_path' },
    { path: '/sessions/new', component: SessionNew, name: 'new_session_path' },
    { path: '/users/new', component: UserNew, name: 'new_user_path' },
    { path: '/users/:id', component: UserShow, name: 'user_path' },
    { path: '/users/:id/edit', component: UserEdit, name: 'edit_user_path' }
  ]
})

router.beforeEach((to, from, next) => {
  // redirect to login page if not logged in and trying to access a restricted page
  const publicPages = ['/sessions/new', '/users/new']
  const authRequired = !publicPages.includes(to.path)
  const loggedIn = localStorage.getItem('user-token')

  if (authRequired && !loggedIn) {
    return next('/sessions/new')
  }

  next()
})

export default router
