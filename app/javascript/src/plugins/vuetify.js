// src/plugins/vuetify.js

import Vue from 'vue/dist/vue.esm'
import Vuetify from 'vuetify'
import 'vuetify/dist/vuetify.min.css'

Vue.use(Vuetify)

const opts = {
  theme: {
    dark: null
  }
}

export default new Vuetify(opts)
