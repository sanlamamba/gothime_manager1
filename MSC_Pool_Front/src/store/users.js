// Utilities
import { defineStore } from 'pinia'

import axios from "axios"
import { Vite_API_URL } from '@/services/url';

export const useUserStore = defineStore('user', {
  state: () => ({
    users: []
  }),
  getters: {
    getUsers(state) {
      return state.users
    }
  },
  actions: {
    setUsers(users) {
      this.users = users;
    },
    async fetchUsers() {
      try {
        const response = await axios.get(Vite_API_URL + 'users/')
        this.setUsers(response.data.data);


      }
      catch (error) {
        alert(error)
        console.group(error)
      }
    }
  },
})
