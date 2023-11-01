import { defineStore } from 'pinia'

import axios from "axios"
import { Vite_API_URL } from '@/services/url';

export const useSchedulesByUserStore = defineStore('schedules', {
     state: () => ({
          schedules: [],
          users: []
     }),
     getters: {
          getSchedulesByUser(state) {
               return state.schedules
          },
          getUsers(state) {
               return state.users;
          },
     },
     actions: {
          setSchedulesByUser(schedules) {
               this.schedules = schedules;
          },
          async fetchSchedulesByUser(userId, startTime, endTime) {
               try
               {
                    const apiUrl = `${Vite_API_URL}schedules/${userId}?start_time=${startTime}&end_time=${endTime}`;

                    const response = await axios.get(apiUrl)

                    this.setSchedulesByUser(response.data.data)
               }
               catch (error)
               {
                    alert(error)
                    console.group(error)


               }
          },
          setUsers(users) {
               this.users = users;
          },
          async fetchUsers() {
               try
               {
                    const response = await axios.get(Vite_API_URL + "users/all");
                    const data = response.data.data;
console.log(data)
                    this.setUsers(data);
               } catch (error)
               {
                    alert(error);
                    console.group(error);
               }
          },


     }
})
