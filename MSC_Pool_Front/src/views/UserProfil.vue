<template>
   <v-container class="bg-surface-variant justify-center">
  <h1> My Profil</h1>
  <v-row no-gutters align="center">
    <v-col
    cols="2">
   
  <UserProfilCard/>
  <ChartDoughnut/>
</v-col>
</v-row>

</v-container>
</template>
<script setup>
import ChartDoughnut from '@/components/ChartDoughnut.vue';
import UserProfilCard from '@/components/UserProfilCard.vue';

</script>

