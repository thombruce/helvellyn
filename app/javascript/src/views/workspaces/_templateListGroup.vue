<template lang="pug">
v-list-group(prepend-icon="mdi-file" :value="isCurrent")
  template(v-slot:activator)
    v-list-item-title {{ template.plural }}
  v-list-item(link :to="{ name: 'entities_path', params: { template_id: template.slug } }" exact)
    v-list-item-content All {{ template.plural }}
    v-list-item-icon
      v-icon mdi-file
  v-list-item(link :to="{ name: 'new_entity_path', params: { template_id: template.slug } }" exact)
    v-list-item-content New {{ template.name }}
    v-list-item-icon
      v-icon mdi-plus
  v-list-item(link :to="{ name: 'edit_template_path', params: { template_id: template.slug } }" exact)
    v-list-item-content {{ template.plural }} Settings
    v-list-item-icon
      v-icon mdi-settings
</template>

<script>
export default {
  props: ['template'],
  computed: {
    isCurrent () {
      return this.$route.params.template_id === this.template.slug
    }
  }
}
</script>