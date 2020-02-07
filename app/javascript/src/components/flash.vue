<template lang="pug">
- flash.each do |key, value|
  .alert{class: "#{flash_class(key)}"}
    = value
    = key
</template>
