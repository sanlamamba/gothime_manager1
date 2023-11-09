<template>
  <v-app id="inspire" v-if="token">
    <v-navigation-drawer
      v-model="drawer"
      app
      class="deep-purple accent-4 white--text"
    >
      <!-- Static User Info centered without image -->
      <v-list-item class="justify-center">
        <v-list-item-content class="align-center">
          <v-list-item-title class="title text-center"
            >John Doe</v-list-item-title
          >
          <v-list-item-subtitle class="text-center"
            >johndoe@example.com</v-list-item-subtitle
          >
        </v-list-item-content>
      </v-list-item>

      <v-divider class="white"></v-divider>

      <!-- Navigation Routes -->
      <v-list dense>
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
          title="users"
          prepend-icon="mdi-account-circle"
          to="/users"
        />
        <v-list-item
          title="teams"
          prepend-icon="mdi-account-circle"
          to="/teams"
        />
        <v-list-item
          title="Manage Team"
          prepend-icon="mdi-account-circle"
          to="/manage/team"
        />
      </v-list>

      <v-spacer></v-spacer>
      <!-- This pushes the logout button to the bottom -->

      <!-- Logout Button at the bottom with spacing -->
      <v-list-item class="mt-auto">
        <v-list-item-content>
          <v-btn block color="red" dark @click="logout">
            Logout
            <v-icon right>mdi-logout</v-icon>
          </v-btn>
        </v-list-item-content>
      </v-list-item>
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
import { useUserStore } from "./store/users.js";
import axios from "axios";
import { Vite_API_URL } from "./services/url";

export default {
  data: () => ({
    snackbar: true,
    drawer: null,
    auth: {
      email: "",
      password: "",
    },
    token: "",
    emailRules: [
      (v) => !!v || "Email is required",
      (v) => /.+@.+\..+/.test(v) || "Email must be valid",
    ],
  }),
  created() {
    // This will run immediately after the instance is created
    this.loggedIn();
  },
  methods: {
    loggedIn() {
      const store = useUserStore();
      store.getAuth();
      const auth = store.getAuth();
      if (auth) {
        this.token = auth.token;
      }
      console.log("LOGGED IN");
    },
    async login() {
      if (this.auth.email || this.auth.password) {
        this.snackbar = true;
        const formData = {
          user: {
            email: this.auth.email,
            password: this.auth.password,
          },
        };
        const response = await axios.post(Vite_API_URL + "login", formData);
        const store = useUserStore();
        store.setAuth(response.data.user, response.data.token);
        const auth = store.getAuth();
        console.log(auth);
        this.token = response.data;
        // store.login(formData);
      }
    },
  },
};
</script>
