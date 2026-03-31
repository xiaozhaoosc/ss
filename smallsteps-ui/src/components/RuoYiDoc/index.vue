<template>
  <div>
    <svg-icon icon-class="question" @click="goto" />
  </div>
</template>

<script setup lang="ts">
const url = ref('https://plus-doc.smallsteps.org/');

function goto() {
  window.open(url.value);
}
</script>
