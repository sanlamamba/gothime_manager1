<template>

    <v-container>

    <v-card>
      <v-row>
      <v-col>
      <v-sheet    class="mx-auto px-6 py-8 mx-auto" max-width="344">
  
  <v-autocomplete
v-model="selected_user"
:items="userItems"
item-value="id"
item-title="username"
label="UserName"
></v-autocomplete>

<v-btn block rounded="0" @click="filterUser">Select User calendar</v-btn>

  </v-sheet>
    <VDatePicker
      v-model="date"
      mode="date"
      is24hr
      :initial-page="{ month: 10, year: 2023 }"
      :color="selectedColor"
      :attributes="calendarAttributes"
      expanded
      show-weeknumbers
    ><template #footer>
      <div class="w-full px-3 pb-3">
         <v-card class="mx-auto px-6 py-8" max-width="344">
      <v-row>
        <v-col cols="12" sm="">
          <div class="d-flex p-4">
            <v-select
              class="p-4"
              v-model="selected_start_time"
              :items="items"
              label="Start Date"
            ></v-select>

            <v-select
              v-model="selected_end_time"
              class="p-4"
              :items="items"
              label="End Date"
            ></v-select>
          </div>
          <v-btn @click="filterRange">Filter Range</v-btn>
        </v-col>
      </v-row>
      </v-card>
      </div>
    </template>
  </VDatePicker>
</v-col>
<v-divider vertical></v-divider>
<v-col>
  <ChartBar/>
<NewSchedules class="pa-6"/>
</v-col>
</v-row>
  </v-card>

   
    </v-container>
    
  


</template>
<script setup>
import { ref, onMounted, computed } from "vue";
import { useSchedulesByUserStore } from "../store/schedulesByUser";
import NewSchedules from "./NewSchedules.vue";
import ChartBar from "@/components/ChartBar.vue";

// Format date for the request
const formatDateToYYYYMMDD = (date) => date.toISOString().slice(0, 10);
// Format date for Popover
const formatDateToHHMM = (date) =>
  `${date.getHours().toString().padStart(2, "0")}:${date
    .getMinutes()
    .toString()
    .padStart(2, "0")}`;

// Filter for date
const start_time = ref(formatDateToYYYYMMDD(new Date("2023-01-01")));
const end_time = ref(formatDateToYYYYMMDD(new Date("2024-12-31")));

const selected_start_time = ref(null);
const selected_end_time = ref(null);

// user id
const selected_user = ref(null);
const userId = 8;

console.log(selected_user);
// The store for schedules by user
const store = useSchedulesByUserStore();
onMounted(() => {
  store.fetchSchedulesByUser(userId, start_time.value, end_time.value);
  store.fetchUsers();
});
const getSchedulesByUser = computed(() => {
  return store.getSchedulesByUser;
});

// User Computed
const getUsers = computed(() => {
  return store.users;
});
const userItems = computed(() => {
  return getUsers.value.map((user) => ({
    username: user.username,
    id: user.id,
  }));
});

const filterUser = () => {
  if (selected_user.value) {
    console.log(start_time, end_time);
    const user_Id = selected_user.value;
    console.log(user_Id);
    store.fetchSchedulesByUser(user_Id, start_time.value, end_time.value);
  }
};

// Filter date Range
const filterRange = () => {
  if (selected_start_time.value && selected_end_time.value) {
    start_time.value = selected_start_time.value;
    end_time.value = selected_end_time.value;
    store.fetchSchedulesByUser(userId, start_time.value, end_time.value);
  }
};

const calendarAttributes = computed(() => {
  return getSchedulesByUser.value.map((schedule) => ({
    key: schedule.id,
    highlight: true,
    dates: {
      start: formatDateToYYYYMMDD(new Date(schedule.start_time)),
      end: formatDateToYYYYMMDD(new Date(schedule.end_time)),
    },
    popover: {
      visibility: "hover-focus",
      isInteractive: false,
      label: `${formatDateToHHMM(
        new Date(schedule.start_time)
      )} - ${formatDateToHHMM(new Date(schedule.end_time))}`,
    },
  }));
});

const selectedColor = ref("blue");
const date = ref(new Date());

const items = computed(() => {
  const currentYear = new Date().getFullYear();
  const startDate = new Date(currentYear, 9, 1); // January 1st of the current year
  const endDate = new Date(currentYear, 11, 31); // December 31st of the current year

  let allDates = [];
  let currentDate = startDate;

  while (currentDate <= endDate) {
    allDates.push(formatDateToYYYYMMDD(new Date(currentDate)));
    currentDate.setDate(currentDate.getDate() + 1); // Move to the next day
  }

  return allDates;
});
</script>
