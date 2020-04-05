import Vue from 'vue/dist/vue.esm'
import VueRouter from 'vue-router'
Vue.use(VueRouter)

import WorkspaceIndex from './views/workspaces/index.vue'
import WorkspaceShow from './views/workspaces/show.vue'
import WorkspaceNew from './views/workspaces/new.vue'
import WorkspaceEdit from './views/workspaces/edit.vue'

import ContentTypeIndex from './views/content_types/index.vue'
import ContentTypeShow from './views/content_types/show.vue'
import ContentTypeNew from './views/content_types/new.vue'
import ContentTypeEdit from './views/content_types/edit.vue'

import ContentEntryIndex from './views/content_entries/index.vue'
import ContentEntryShow from './views/content_entries/show.vue'
import ContentEntryNew from './views/content_entries/new.vue'
import ContentEntryEdit from './views/content_entries/edit.vue'

import Login from './views/authentication/login.vue'
import Signup from './views/authentication/signup.vue'
import Account from './views/authentication/account.vue'

const router = new VueRouter({
  mode: 'history',
  routes: [
    { path: '/', component: WorkspaceIndex, name: 'root_path' },
    { path: '/login', component: Login, name: 'login_path', meta: { layout: "authentication" } },
    { path: '/signup', component: Signup, name: 'signup_path', meta: { layout: "authentication" } },
    { path: '/account', component: Account, name: 'account_path' },
    { path: '/workspaces', component: WorkspaceIndex, name: 'workspaces_path' },
    { path: '/workspaces/new', component: WorkspaceNew, name: 'new_workspace_path' },
    { path: '/:workspace_id/edit', component: WorkspaceEdit, name: 'edit_workspace_path' },
    { path: '/:workspace_id', component: WorkspaceShow,
      children: [
        { path: '', component: ContentTypeIndex, name: 'content_types_path' },
        { path: 'content_types/new', component: ContentTypeNew, name: 'new_content_type_path' },
        { path: ':content_type_id/edit', component: ContentTypeEdit, name: 'edit_content_type_path' },
        { path: ':content_type_id', component: ContentTypeShow,
          children: [
            { path: '', component: ContentEntryIndex, name: 'content_entries_path' },
            { path: 'new', component: ContentEntryNew, name: 'new_content_entry_path' },
            { path: ':content_entry_id/edit', component: ContentEntryEdit, name: 'edit_content_entry_path' },
            { path: ':content_entry_id', component: ContentEntryShow, name: 'content_entry_path' }
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
