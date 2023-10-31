<template>
  <v-card>
  <Doughnut :data="data" :options="options" />
</v-card>
</template>

<script lang="ts">
import { Chart as ChartJS, ArcElement, Tooltip, Legend } from 'chart.js'
import { Doughnut } from 'vue-chartjs'
import * as chartDoughnutConfig from '../services/chartDoughnutConfig'

ChartJS.register(ArcElement, Tooltip, Legend)

export default {
  name: 'App',
  components: {
    Doughnut
  },
  data() {
    return chartDoughnutConfig
  }
}
</script>
