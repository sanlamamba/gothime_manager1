// Utilities
import { defineStore } from "pinia";

import axios from "axios";
import { Vite_API_URL } from "@/services/url";

export const useUserStore = defineStore("user", {
  state: () => ({
    users: [],
    teams: [],
  }),
  getters: {
    getUsers(state) {
      return state.users;
    },
    getTeams(state) {
      return state.teams;
    },
  },
  actions: {
    setUsers(users) {
      this.users = users;
    },
    async fetchUsers() {
      try {
        const response = await axios.get(Vite_API_URL + "users/all");
        const filteredData = response.data.data.filter((u) => u.is_visible);
        this.setUsers(filteredData);
      } catch (error) {
        alert(error);
        console.group(error);
      }
    },
    setTeams(teams) {
      this.teams = teams;
    },
    async fetchTeams() {
      try {
        const response = await axios.get(Vite_API_URL + "teams");
        this.setTeams(response.data.data);
      } catch (error) {
        alert(error);
        console.group(error);
      }
    },
  },
});
