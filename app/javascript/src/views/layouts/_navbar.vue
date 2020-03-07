<template lang="pug">
div
  v-app-bar(app)
    v-app-bar-nav-icon(@click.stop="drawer = !drawer")
    v-toolbar-title
      router-link(:to="{ name: 'root_path' }") CMS by Thom
    v-spacer
    v-btn(icon)
      v-icon mdi-heart
  drawer(:drawer="drawer")
</template>

<script>
import Session from '../../mixins/session.js'
import Workspaces from '../../mixins/workspaces.js'
import Drawer from './_drawer.vue'
export default {
  mixins: [
    Session,
    Workspaces
  ],
  components: {
    Drawer
  },
  data: () => ({
    drawer: null
  }),
  methods: {
    signOut: function () {
      this.$store.dispatch('sessions/destroy').then(() => {
        this.$router.push('/sessions/new')
      })
    }
  }
}
</script>
