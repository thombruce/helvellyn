<template lang="pug">
v-list
  v-list-item
    v-list-item-title {{ workspace.title }}
  v-list-item(v-for="content_type in workspace.content_types" link :to="{ name: 'content_type_path', params: { content_typeId: content_type.slug } }") {{ content_type.name }}
  v-list-item(link :to="{ name: 'new_content_type_path' }")
    v-list-item-icon
      v-icon mdi-plus
    v-list-item-content New Type
</template>

<script>
export default {
  props: [
    'workspace'
  ]
}
</script>
