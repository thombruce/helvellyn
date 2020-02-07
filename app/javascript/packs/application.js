// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

// require("@rails/ujs").start()
// require("turbolinks").start()
// require("@rails/activestorage").start()
// require("channels")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import Vue from 'vue/dist/vue.esm'
import store from '../src/store'
import router from '../src/routes.js'

import 'bootstrap'

import NavBar from '../src/components/navbar'
Vue.component('nav-bar', NavBar)

import Layout from '../src/components/layout'
Vue.component('layout', Layout)

const app = new Vue({
  router,
  store
}).$mount('#app')

// Based on: https://github.com/gbarillot/rails-vue-demo-app/blob/master/app/javascript/packs/application.js
