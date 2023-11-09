import axios from "axios";
import { Vite_API_URL } from "../url";
import { formatNaiveDatetime } from "../formatDate";

export async function postSchedule(userId, start, end) {
  try {
    const response = await axios.post(`${Vite_API_URL}schedules/`, {
      schedule: {
        start_time: formatNaiveDatetime(start),
        end_time: formatNaiveDatetime(end),
        user_id: userId,
      },
    });
    console.log(response, "la Réponse !");
    return response;
  } catch (error) {
    console.log(error);
    alert(error);
  }
}
