<template>
  <v-container class="bg-surface-indigo-lighten-5 justify-center">
    <v-row no-gutters>
      <v-col class="col-12"> </v-col>
    </v-row>
    <v-row no-gutters>
      <v-col cols="12">
        <v-row no-gutters>
          <v-col cols="12" class="pr-5">
            <TeamTable />
          </v-col>
        </v-row>
      </v-col>
    </v-row>
  </v-container>
</template>

<script setup>
import TeamTable from "@/components/TeamTable.vue";
</script>

<script>
export default {
  data: () => ({}),
  created() {},
  computed: {},
  watch: {},

  methods: {},
};
</script>
