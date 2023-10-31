<template>
<h1> Mon Calendrier</h1>
<GanttChart/>
<SchedulesCalendar/>
<h1>{{ msg }}</h1>
    <h1>Made By Getters</h1>
    <div v-for="schedules in getSchedules" :key="schedules.id">
      {{ schedules.id }} {{ schedules.start_time }} {{ schedules.end_time }}
    </div>
    <h1>Made By Actions</h1>
    <div v-for="schedules in schedules" :key="schedules.id">
      {{ schedules.id }}  {{ schedules.start_time }} {{ schedules.end_time }}
    </div>
 
</template>
  
<script setup>
import GanttChart from '@/components/GanttChart.vue';
import SchedulesCalendar from "@/components/SchedulesCalendar.vue"
import { ref, onMounted, computed } from "vue";
import { useSchedulesStore } from '@/store/schedules';

const msg = ref("All the Working Time");

const store = useSchedulesStore();
const getSchedules = computed(() => {
  return store.getSchedules;
});
const schedules = computed(() => {
  return store.schedules;
});
onMounted(() => {
  store.fetchSchedules();
});
</script>


