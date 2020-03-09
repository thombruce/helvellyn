import Vue from 'vue/dist/vue.esm'
import VueRouter from 'vue-router'
Vue.use(VueRouter)

import PostIndex from './views/posts/index.vue'
import PostShow from './views/posts/show.vue'
import PostNew from './views/posts/new.vue'
import PostEdit from './views/posts/edit.vue'

import WorkspaceIndex from './views/workspaces/index.vue'
import WorkspaceShow from './views/workspaces/show.vue'
import WorkspaceNew from './views/workspaces/new.vue'
import WorkspaceEdit from './views/workspaces/edit.vue'

import ContentTypeIndex from './views/content_types/index.vue'
import ContentTypeShow from './views/content_types/show.vue'
import ContentTypeNew from './views/content_types/new.vue'
import ContentTypeEdit from './views/content_types/edit.vue'

import SessionNew from './views/sessions/new.vue'

import UserShow from './views/users/show.vue'
import UserNew from './views/users/new.vue'
import UserEdit from './views/users/edit.vue'

const router = new VueRouter({
  mode: 'history',
  routes: [
    { path: '/', component: WorkspaceIndex, name: 'root_path' },
    { path: '/workspaces', component: WorkspaceIndex, name: 'workspaces_path' },
    { path: '/workspaces/new', component: WorkspaceNew, name: 'new_workspace_path' },
    { path: '/workspaces/:workspaceId', component: WorkspaceShow, name: 'workspace_path',
      children: [
        { path: 'content_types', component: ContentTypeIndex, name: 'content_types_path' },
        { path: 'content_types/new', component: ContentTypeNew, name: 'new_content_type_path' },
        { path: 'content_types/:content_typeId', component: ContentTypeShow, name: 'content_type_path' },
        { path: 'content_types/:content_typeId/edit', component: ContentTypeEdit, name: 'edit_content_type_path' },
        { path: 'posts', component: PostIndex, name: 'posts_path' },
        { path: 'posts/new', component: PostNew, name: 'new_post_path' },
        { path: 'posts/:postId', component: PostShow, name: 'post_path' },
        { path: 'posts/:postId/edit', component: PostEdit, name: 'edit_post_path' }
      ] },
    { path: '/workspaces/:workspaceId/edit', component: WorkspaceEdit, name: 'edit_workspace_path' },
    { path: '/sessions/new', component: SessionNew, name: 'new_session_path', meta: { layout: "authentication" } },
    { path: '/users/new', component: UserNew, name: 'new_user_path', meta: { layout: "authentication" } },
    { path: '/users/:userId', component: UserShow, name: 'user_path' },
    { path: '/users/:userId/edit', component: UserEdit, name: 'edit_user_path' }
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
