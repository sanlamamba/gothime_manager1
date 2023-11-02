<template>
  <VDatePicker v-model="range" mode="dateTime" is-range>
    <template #footer>
      <div class="w-full px-4 pb-3">
        <v-btn
          class="bg-indigo-600 hover:bg-indigo-700 text-white font-bold w-full px-3 py-1 rounded-md"
          @click="AddSchedule"
        >
          AddSchedule
        </v-btn>
      </div>
    </template></VDatePicker
  >
</template>

   <script setup>
import { ref } from "vue";
import { postSchedule } from "@/services/functions/schedules";
const now = new Date();

// Set the start hour (e.g., 9 AM)
const startHour = new Date(now);
startHour.setHours(9, 0, 0, 0); // 9 AM

// Set the end hour (e.g., 5 PM)
const endHour = new Date(now);
endHour.setHours(17, 0, 0, 0); // 5 PM

const range = ref({
  start: startHour,
  end: endHour,
});
const userId = 8;

function AddSchedule() {
  const start = range.value.start;
  const end = range.value.end;

  return postSchedule(userId, start, end);
}
console.log(AddSchedule, "--- Post");
</script>