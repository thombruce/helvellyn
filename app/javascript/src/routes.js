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

import SessionNew from './views/sessions/new.vue'

import UserShow from './views/users/show.vue'
import UserNew from './views/users/new.vue'
import UserEdit from './views/users/edit.vue'

const router = new VueRouter({
  mode: 'history',
  routes: [
    { path: '/', component: WorkspaceIndex, name: 'root_path' },
    { path: '/sessions/new', component: SessionNew, name: 'new_session_path', meta: { layout: "authentication" } },
    { path: '/users/new', component: UserNew, name: 'new_user_path', meta: { layout: "authentication" } },
    { path: '/users/:user_id', component: UserShow, name: 'user_path' },
    { path: '/users/:user_id/edit', component: UserEdit, name: 'edit_user_path' },
    { path: '/workspaces', component: WorkspaceIndex, name: 'workspaces_path' },
    { path: '/workspaces/new', component: WorkspaceNew, name: 'new_workspace_path' },
    { path: '/:workspace_id', component: WorkspaceShow, name: 'workspace_path',
      children: [
        { path: 'content_types', component: ContentTypeIndex, name: 'content_types_path' },
        { path: 'content_types/new', component: ContentTypeNew, name: 'new_content_type_path' },
        { path: ':content_type_id', component: ContentTypeShow,
          children: [
            { path: '', component: ContentEntryIndex, name: 'content_entries_path' },
            { path: 'new', component: ContentEntryNew, name: 'new_content_entry_path' },
            { path: ':content_entry_id', component: ContentEntryShow, name: 'content_entry_path' },
            { path: ':content_entry_id/edit', component: ContentEntryEdit, name: 'edit_content_entry_path' }
          ] },
        { path: ':content_type_id/edit', component: ContentTypeEdit, name: 'edit_content_type_path' }
      ] },
    { path: '/:workspace_id/edit', component: WorkspaceEdit, name: 'edit_workspace_path' }
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
