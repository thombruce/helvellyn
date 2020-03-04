<template lang="pug">
header.navbar.navbar-expand-lg.navbar-dark.bg-primary
  strong
    router-link.navbar-brand(:to="{ name: 'root_path' }") CMS by Thom
  nav.collapse.navbar-collapse
    ul.navbar-nav(v-if="currentUser")
      li.nav-item.dropdown
        a#navbarBlogDropdown.nav-link.dropdown-toggle(href='#' role='button' data-toggle='dropdown' aria-haspopup=true aria-expanded='false')
          template(v-if="currentBlog")
            | {{ currentBlog.title }}
          template(v-else)
            | Blogs
        .dropdown-menu.dropdown-menu-left(aria-leballedBy='navbarBlogDropdown')
          template(v-if="blogs")
            router-link.dropdown-item(v-for="blog in blogs" :to="{ name: 'blog_path', params: { blogId: blog.id } }") {{ blog.title }}
            .dropdown-divider
          router-link.dropdown-item(:to="{ name: 'new_blog_path' }") New Blog
    ul.navbar-nav.ml-auto
      li.nav-item.dropdown(v-if="currentUser")
        a#navbarUserDropdown.nav-link.dropdown-toggle(href='#' role='button' data-toggle='dropdown' aria-haspopup=true aria-expanded='false')
          | {{ currentUser.name }}
        .dropdown-menu.dropdown-menu-right(aria-leballedBy='navbarUserDropdown')
          router-link.dropdown-item(:to="{ name: 'user_path', params: { userId: currentUser.id } }") Account
          a.dropdown-item(v-on:click.stop="signOut" href="javascript:;") Sign out
      template(v-else)
        li.nav-item
          router-link.nav-link(:to="{ name: 'new_session_path' }") Sign in
        li.nav-item
          router-link.nav-link(:to="{ name: 'new_user_path' }") Sign up
</template>

<script>
import Session from '../../mixins/session.js'
import Blogs from '../../mixins/blogs.js'
export default {
  mixins: [
    Session,
    Blogs
  ],
  methods: {
    signOut: function () {
      this.$store.dispatch('sessions/destroy').then(() => {
        this.$router.push('/sessions/new')
      })
    }
  }
}
</script>
