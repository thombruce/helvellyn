import Vue from 'vue/dist/vue.esm'
import VueRouter from 'vue-router'
Vue.use(VueRouter)

import PostIndex from './views/posts/index.vue'
import PostShow from './views/posts/show.vue'
import PostNew from './views/posts/new.vue'
import PostEdit from './views/posts/edit.vue'

import SessionNew from './views/sessions/new.vue'

import UserShow from './views/users/show.vue'
import UserNew from './views/users/new.vue'
import UserEdit from './views/users/edit.vue'

const router = new VueRouter({
  mode: 'history',
  routes: [
    { path: '/', component: PostIndex, name: 'root_path' },
    { path: '/posts', component: PostIndex, name: 'posts_path' },
    { path: '/posts/new', component: PostNew, name: 'new_post_path' },
    { path: '/posts/:id', component: PostShow, name: 'post_path' },
    { path: '/posts/:id/edit', component: PostEdit, name: 'edit_post_path' },
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
  } else if (!authRequired && loggedIn) {
    return next('/')
  }

  next()
})

export default router
