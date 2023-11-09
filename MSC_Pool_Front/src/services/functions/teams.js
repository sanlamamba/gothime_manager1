import axios from "axios";
import { Vite_API_URL } from "../url";

export function formatTeam(data) {
  const formData = {
    team: {},
  };
  formData.team.id = data.id || null;
  formData.team.name = data.name;
  formData.team.description = data.description;
  formData.team.user_id = data.user_id || null;

  return formData;
}
export async function createTeam(data, callbacks = [], error_callbacks = []) {
  try {
    const response = await axios.post(Vite_API_URL + "teams", data);
    callbacks.forEach((callback) => callback(response));
  } catch (error) {
    error_callbacks.forEach((callback) => callback(error));
  }
}

export async function updateTeam(data, callbacks = [], error_callbacks = []) {
  try {
    const response = await axios.put(
      Vite_API_URL + `teams/${data.team.id}`,
      data
    );
    callbacks.forEach((callback) => callback(response));
  } catch (error) {
    error_callbacks.forEach((callback) => callback(error));
  }
}

export async function deleteTeam(data, callbacks = [], error_callbacks = []) {
  try {
    const response = await axios.delete(
      Vite_API_URL + `teams/${data.team.id}`,
      data
    );
    callbacks.forEach((callback) => callback(response));
  } catch (error) {
    error_callbacks.forEach((callback) => callback(error));
  }
}
