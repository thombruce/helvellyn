<template lang="pug">
v-form(ref="form" :model="workspace")
  v-text-field(label="Title" v-model="workspace.title" @input="updateSlug" hint="The name of your workspace (e.g. My Awesome Blog)")

  v-text-field(label="Slug" :prefix="baseUrl" v-model="workspace.slug" hint="The URL path of your workspace (e.g. my-awesome-blog)")

  v-btn(color="primary" @click="submit") Submit
</template>

<script>
var parameterize = require('parameterize')

export default {
  props: [
    'workspace',
    'submit'
  ],
  computed: {
    baseUrl() {
      return window.location.host + "/" // TODO: A configurable URL would be better, for reusability in open source and app form.
    }
  },
  methods: {
    updateSlug () {
      if (!this.workspace.id) {
        this.workspace.slug = parameterize(this.workspace.title)
      }
    }
  }
}
</script>
