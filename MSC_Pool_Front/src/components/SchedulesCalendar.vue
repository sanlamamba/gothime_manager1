<template>

  <VDatePicker v-model="date" mode="dateTime" is24hr  :initial-page="{ month: 4, year: 2019 }"
    :color="selectedColor"
    :attributes="attrs"
    expanded
    show-weeknumbers />
</template>
<script setup>
import { ref } from 'vue';





// Calendar attributes
const selectedColor = ref('blue');
const date = ref(new Date())
const attrs = ref([
  {
    key: 'test',
    highlight: true,
    dates: { start: new Date(2019, 3, 15), end: new Date(2019, 3, 19) },
  }
]);

</script>
