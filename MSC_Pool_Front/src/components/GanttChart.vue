<template>
  <g-gantt-chart
    chart-start="{{chartStart}}"
    chart-end="{{chartEnd}}"
    precision="hour"
    bar-start="myBeginDate"
    bar-end="myEndDate"
  >
  <g-gantt-row label="Schedules" :bars="transformedSchedules" />
  </g-gantt-chart>
</template>

<script setup>
import { ref, onMounted, computed } from "vue";



import { useSchedulesByUserStore } from "../store/schedulesByUser";
const msg = ref("All the Working Time");
const formatDateToYYYYMMDD = date => date.toISOString().slice(0, 10);

const start_time = "2023-10-09";
const end_time = "2023-10-24";

const chartStart = start_time + " 00:00"; // Start of the day
const chartEnd = end_time + " 23:59"; // End of the day


const userId = 8;
console.log("userId:", userId);

const store = useSchedulesByUserStore();
const getSchedulesByUser = computed(() => {
  return store.getSchedulesByUser;
});

console.log(getSchedulesByUser);
const schedules = computed(() => {
  return store.schedules;
});


const transformedSchedules = computed(() => {
  return schedules.value.map(schedule => ({
    myBeginDate: formatDateToYYYYMMDD(new Date(schedule.start_time)) + " 00:00",
    myEndDate: formatDateToYYYYMMDD(new Date(schedule.end_time)) + " 23:59",
    ganttBarConfig: {
      id: schedule.id.toString(), // Convert id to string
      label: `Schedule ${schedule.id}`
      // Add any other properties or styles as needed
    }
  }));
});
onMounted(() => {
  store.fetchSchedulesByUser(userId, start_time, end_time);
});

</script>
