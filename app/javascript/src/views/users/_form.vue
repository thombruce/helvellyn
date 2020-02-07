<template lang="pug">
form()
  .form-group
    label(for="nameInput") Name
    input#nameInput.form-control(:value="user.name")
  .form-group
    label(for="emailInput") Email
    input#emailInput.form-control(type="email" :value="user.email")
  .form-group
    label(for="passwordInput") Password
    input#passwordInput.form-control(type="password" :value="user.password")
  button Submit
</template>

<script>
export default {
  props: ['user']
}
</script>
