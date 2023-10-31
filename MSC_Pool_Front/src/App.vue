<template>
  <v-app id="inspire">
    <v-navigation-drawer v-model="drawer">
      <v-list-item title="GoThime Manager" subtitle="Vuetify"></v-list-item>
      <v-divider></v-divider>

      <v-list-item title="Dashboard" prepend-icon="mdi-home" to="/" />
      <v-list-item
        title="Profil"
        prepend-icon="mdi-account-circle"
        to="/profil"
      />
      <v-list-item
        title="Calendar"
        prepend-icon="mdi-clock-start"
        to="/calendar"
      />
      <v-list-item
        title="myTeam"
        prepend-icon="mdi-account-supervisor-circle"
        to="/myTeam"
      />
    </v-navigation-drawer>

    <v-app-bar>
      <v-app-bar-nav-icon @click="drawer = !drawer"></v-app-bar-nav-icon>

      <v-app-bar-title>Gothime Manager</v-app-bar-title>
    </v-app-bar>

    <v-main>
      <router-view />
    </v-main>
    <v-bottom-navigation :elevation="3" grow>
      <v-btn value="recent">
        <v-icon>mdi-history</v-icon>

        <span>Recent</span>
      </v-btn>

      <v-btn value="favorites">
        <v-icon>mdi-heart</v-icon>

        <span>Favorites</span>
      </v-btn>

      <v-btn value="nearby">
        <v-icon>mdi-map-marker</v-icon>

        <span>Nearby</span>
      </v-btn>
    </v-bottom-navigation>
  </v-app>
</template>

<script setup>
import { ref } from "vue";

const drawer = ref(null);
</script>

<script>
export default {
  data: () => ({ drawer: null }),
};
</script>
