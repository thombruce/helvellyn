<template lang="pug">
div
  v-card(outlined)
    v-card-title Helvellyn
    v-card-subtitle
      span.subtitle-1
        strong Version
        |
        | {{ $store.getters.appVersion }}
    v-card-text
      p Thank you for using Helvellyn CMS.
  settings-form(:settings="settings")
</template>

<script>
import SettingsForm from './_form.vue'

export default {
  components: {
    SettingsForm
  },
  data () {
    return {
      settings: {
        errors: []
      }
    }
  },
  created () {
    this.fetchData()
  },
  watch: {
    '$route': 'fetchData'
  },
  methods: {
    fetchData () {
      this.$store.dispatch('settings/show').then(() => {
        this.settings = this.$store.state.settings.list
      })
    }
  }
}
</script>
