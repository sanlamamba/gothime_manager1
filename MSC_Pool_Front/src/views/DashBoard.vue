<template>

<ChartBar/>


   <v-container class="justify-center ">
  <h1> My Profil</h1>
  <v-row no-gutters align="center">
    <v-col
    cols="2">

  <UserProfilCard/>
</v-col>
<ChartDoughnut/>
</v-row>

</v-container>


 <SchedulesCalendar />
</template>

<script setup>
import SchedulesCalendar from "@/components/SchedulesCalendar.vue";
import ChartDoughnut from '@/components/ChartDoughnut.vue';
import ChartBar from "@/components/ChartBar.vue";
import UserProfilCard from '@/components/UserProfilCard.vue';
</script>
