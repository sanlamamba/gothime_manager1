import { defineStore } from 'pinia'

import axios from "axios"
import { Vite_API_URL } from '@/services/url';

export const useSchedulesStore = defineStore('schedules', {
  state: () => ({
    schedules: []
  }),
  getters: {
    getSchedules(state) {
      return state.schedules
    }
  },
  actions: {
    setSchedules(schedules) {
      this.schedules = schedules;
    },
    async fetchSchedules() {
      try
      {
        const response = await axios.get(Vite_API_URL + 'schedules')
        this.setSchedules(response.data.data)
      }
      catch (error)
      {
        alert(error)
        console.group(error)

      }
    }


  }
})
