import axios from "axios";
import { Vite_API_URL } from "../url";




function addSchedules(userId, start, end) {
     axios.post(`${Vite_API_URL}schedules/${userId}`, {
          start_time: start
     })

} 