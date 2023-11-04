<template>
  <v-app id="inspire" v-if="connected">
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
  <v-app v-else class="bg-blue">
    <v-snackbar v-model="snackbar">
      <v-icon color="white">mdi-alert-circle</v-icon>
      <span class="white--text">You are not connected</span>
    </v-snackbar>
    <v-row align="center" justify="center">
      <v-col cols="12" sm="8" md="4">
        <v-card class="px-5 py-5">
          <v-card-title class="text-h6 text-center pb-5">Login</v-card-title>
          <v-card-text>
            <v-form @submit.prevent="login">
              <v-text-field
                v-model="auth.email"
                label="Email"
                prepend-icon="mdi-email"
                outlined
                required
                :rules="emailRules"
              ></v-text-field>
              <v-text-field
                v-model="auth.password"
                label="Password"
                prepend-icon="mdi-lock"
                outlined
                required
                type="password"
              ></v-text-field>
              <v-row>
                <v-col cols="12" sm="6" md="4">
                  <v-btn color="primary" type="submit" block>Login</v-btn>
                </v-col>
              </v-row>
            </v-form>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-app>
</template>

<script setup>
import { ref } from "vue";

const drawer = ref(null);
</script>

<script>
export default {
  data: () => ({
    snackbar: true,
    drawer: null,
    connected: false,
    auth: {
      email: "",
      password: "",
    },
    emailRules: [
      (v) => !!v || "Email is required",
      (v) => /.+@.+\..+/.test(v) || "Email must be valid",
    ],
  }),
  methods: {
    login() {
      const formData = {
        email: this.auth.email,
        password: this.auth.password,
      };
      console.log(formData);
      this.connected = true;
    },
  },
};
</script>
