<template lang="pug">
v-app
  v-content
    v-container(class="fill-height" fluid)
      v-row(align="center" justify="center")
        v-col(cols="12" sm="8" md="4")
          slot
</template>
