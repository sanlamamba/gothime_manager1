<template>
  <Bar
    id="my-chart-id"
    :options="chartOptions"
    :data="chartData"
  />


</template>

<script setup>

import { ref, onMounted, computed } from "vue";
import { useSchedulesByUserStore } from "../store/schedulesByUser";
import { Bar } from 'vue-chartjs'
import { Chart as ChartJS, Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale } from 'chart.js'

ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale)
const msg = ref("All the Working Time");
const formatDateToYYYYMMDD = date => date.toISOString().slice(0, 10);

const start_time = formatDateToYYYYMMDD(new Date("2023-10-09"));
const end_time = formatDateToYYYYMMDD(new Date("2023-10-24"));

const userId = 8;
console.log("userId:", userId);

const store = useSchedulesByUserStore();
const getSchedulesByUser = computed(() => {
return store.getSchedulesByUser;
});
const getMonthFromDateString = dateStr => {
  const date = new Date(dateStr);
  return date.toLocaleString('default', { month: 'long' });
};

// Aggregate schedules by month
const schedulesByMonth = computed(() => {
  const monthData = {};

  schedules.value.forEach(schedule => {
    const month = getMonthFromDateString(schedule.start_time);
    const startTime = new Date(schedule.start_time);
    const endTime = new Date(schedule.end_time);
    const duration = (endTime - startTime) / (1000 * 60 * 60); // Convert to hours

    if (!monthData[month]) {
      monthData[month] = 0;
    }
    monthData[month] += duration;
  });

  return monthData;
});

// Update chart data based on aggregated data
const chartData = computed(() => ({
  labels: Object.keys(schedulesByMonth.value),
  datasets: [{
    data: Object.values(schedulesByMonth.value),
    backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56'], // Add more colors if needed
    label: 'Schedules by Month'
  }]
}));

console.log(getSchedulesByUser);
const schedules = computed(() => {
return store.schedules;
});
onMounted(() => {
store.fetchSchedulesByUser(userId, start_time, end_time);
});




</script>
  
