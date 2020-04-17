import Vue from 'vue/dist/vue.esm'
import VueRouter from 'vue-router'
Vue.use(VueRouter)

import AdminIndex from './views/admin/index.vue'

import WorkspaceIndex from './views/workspaces/index.vue'
import WorkspaceShow from './views/workspaces/show.vue'
import WorkspaceNew from './views/workspaces/new.vue'
import WorkspaceEdit from './views/workspaces/edit.vue'

import UserIndex from './views/users/index.vue'
import UserShow from './views/users/show.vue'
import UserNew from './views/users/new.vue'
import UserEdit from './views/users/edit.vue'

import TemplateIndex from './views/templates/index.vue'
import TemplateShow from './views/templates/show.vue'
import TemplateNew from './views/templates/new.vue'
import TemplateEdit from './views/templates/edit.vue'

import EntityIndex from './views/entities/index.vue'
import EntityShow from './views/entities/show.vue'
import EntityNew from './views/entities/new.vue'
import EntityEdit from './views/entities/edit.vue'

import Login from './views/authentication/login.vue'
import Signup from './views/authentication/signup.vue'
import Account from './views/authentication/account.vue'

const router = new VueRouter({
  mode: 'history',
  routes: [
    { path: '/', component: WorkspaceIndex, name: 'root_path' },
    { path: '/admin', component: AdminIndex, name: 'admin_path' },
    { path: '/login', component: Login, name: 'login_path', meta: { layout: "authentication" } },
    { path: '/signup', component: Signup, name: 'signup_path', meta: { layout: "authentication" } },
    { path: '/account', component: Account, name: 'account_path' },
    { path: '/workspaces', component: WorkspaceIndex, name: 'workspaces_path' },
    { path: '/workspaces/new', component: WorkspaceNew, name: 'new_workspace_path' },
    { path: '/:workspace_id/edit', component: WorkspaceEdit, name: 'edit_workspace_path' },
    { path: '/:workspace_id', component: WorkspaceShow,
      children: [
        { path: '', component: TemplateIndex, name: 'templates_path' },
        { path: 'users', component: UserIndex, name: 'users_path' },
        { path: 'users/new', component: UserNew, name: 'new_user_path' },
        { path: 'users/:user_id/edit', component: UserEdit, name: 'edit_user_path' },
        { path: 'users/:user_id', component: UserShow, name: 'user_path' },
        { path: 'templates/new', component: TemplateNew, name: 'new_template_path' },
        { path: ':template_id/edit', component: TemplateEdit, name: 'edit_template_path' },
        { path: ':template_id', component: TemplateShow,
          children: [
            { path: '', component: EntityIndex, name: 'entities_path' },
            { path: 'new', component: EntityNew, name: 'new_entity_path' },
            { path: ':entity_id/edit', component: EntityEdit, name: 'edit_entity_path' },
            { path: ':entity_id', component: EntityShow, name: 'entity_path' }
          ] }
      ] }
  ]
})

router.beforeEach((to, from, next) => {
  // redirect to login page if not logged in and trying to access a restricted page
  const publicPages = ['/login', '/signup']
  const authRequired = !publicPages.includes(to.path)
  const loggedIn = localStorage.getItem('user-token')

  if (authRequired && !loggedIn) {
    return next('/login')
  } else if (!authRequired && loggedIn) {
    return next('/')
  }

  next()
})

export default router
