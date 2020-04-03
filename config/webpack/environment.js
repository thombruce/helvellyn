const { environment } = require('@rails/webpacker')
const { VueLoaderPlugin } = require('vue-loader')
const vue = require('./loaders/vue')
const pug = require('./loaders/pug')
// const scss = require('./loaders/scss') // [1]

environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
environment.loaders.prepend('vue', vue)
environment.loaders.prepend('pug', pug)
// environment.loaders.prepend('scss', scss) // [1]

const resolver = {
  resolve: {
    alias: {
      'vue$': 'vue/dist/vue.esm.js'
    }
  }
}
environment.config.merge(resolver)

module.exports = environment

// [1] Removed custom SCSS loader as it appears to conflict with Vuetify.
//     I believe it was originally added when using Bootstrap to template,
//     and was required to compile SCSS to CSS. Best guess: Vuetify now
//     handles that for us, and our loader conflicts with it.
