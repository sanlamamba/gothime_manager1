// Utilities
import { defineStore } from "pinia";

import axios from "axios";
import { Vite_API_URL } from "@/services/url";

export const useUserStore = defineStore("user", {
  state: () => ({
    users: [],
    teams: [],
    memberships: [],
    schedules: [],
    clocks: [],
    auth: {
      user: null,
      token: null,
    },
  }),
  getters: {
    getUsers(state) {
      return state.users;
    },
    getUser(state, userID) {
      const data = {
        user: null,
        team: null,
      };
      data.user = state.users.find((user) => user.id === userID);
      if (data.user === null) return new Error("User not found");
      data.team = state.teams.find((team) => team.id === data.user.team_id);
      return data;
    },
    getTeams(state) {
      return state.teams;
    },
    getSchedules(state) {
      return state.schedules;
    },
    getClocks(state) {
      return state.clocks;
    },
  },
  setters: {},
  actions: {
    getAuth() {
      const token = JSON.parse(window.localStorage.getItem("token"));
      const user = JSON.parse(window.localStorage.getItem("user"));
      this.auth = {
        user,
        token,
      };
      return {
        user,
        token,
      };
    },
    setAuth(user, token) {
      console.log("setAuth", user, token);
      this.auth.user = user;
      this.auth.token = token;
      window.localStorage.setItem("user", JSON.stringify(user));
      window.localStorage.setItem("token", JSON.stringify(token));
    },
    setUsers(users) {
      this.users = users;
    },
    setSchedules(schedules) {
      this.schedules = schedules;
    },
    setClocks(clocks) {
      this.clocks = clocks;
    },
    setTeams(teams) {
      this.teams = teams;
    },
    setMemberships(memberships) {
      this.memberships = memberships;
    },
    getUserByID(userID) {
      const user = this.users.find((user) => user.id === userID);
      return user;
    },
    getMembershipsByUser(userID) {
      const memberships = this.memberships.filter((m) => m.user_id === userID);
      return memberships;
    },
    getData() {
      this.fetchUsers();
      this.fetchTeams();
      this.fetchMemberships();
      this.fetchSchedules();
      this.fetchAllClocks();
    },
    async fetchUsers() {
      try {
        const response = await axios.get(Vite_API_URL + "users/all");
        // const filteredData = response.data.data.filter((u) => !u.is_visible);
        this.setUsers(response.data.data);
      } catch (error) {
        alert(error);
        console.group(error);
      }
    },
    async fetchSchedules() {
      try {
        const response = await axios.get(Vite_API_URL + "schedules");
        this.setSchedules(response.data.data);
      } catch (error) {
        alert(error);
        console.group(error);
      }
    },

    async fetchClocks(user_id) {
      try {
        const response = await axios.get(
          Vite_API_URL + `clocks/?user_id=${user_id}`
        );
        return response.data.data;
      } catch (error) {
        alert(error);
        console.group(error);
      }
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
    async fetchUser(userID) {
      try {
        const response = await axios.get(Vite_API_URL + `users/${userID}`);
        this.setUsers(response.data.data);
      } catch (error) {
        alert(error);
        console.group(error);
      }
    },
    async fetchMemberships() {
      try {
        const response = await axios.get(Vite_API_URL + "memberships");
        this.setMemberships(response.data.data);
      } catch (error) {
        alert(error);
        console.group(error);
      }
    },
    async fetchAllClocks() {
      try {
        const response = await axios.get(Vite_API_URL + "clocks/all");
        this.setClocks(response.data.data);
      } catch (error) {
        alert(error);
        console.group(error);
      }
    },

    getMembershipsForTeam(team_id) {
      return this.memberships.filter((m) => m.team_id === team_id);
    },
  },
});
