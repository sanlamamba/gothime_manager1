import axios from "axios";
import { Vite_API_URL } from "../url";

export function formatUser(userData) {
  const formData = {
    user: {},
  };
  formData.user.id = userData.id;
  formData.user.username = userData.username;
  formData.user.email = userData.email;
  formData.user.team_id = userData.team_id;
  return formData;
}
export async function createUser(data, callbacks = [], error_callbacks = []) {
  try {
    const response = await axios.put(Vite_API_URL + "users", data);
    callbacks.forEach((callback) => callback(response));
  } catch (error) {
    error_callbacks.forEach((callback) => callback(error));
  }
}

export async function updateUser(data, callbacks = [], error_callbacks = []) {
  try {
    const response = await axios.put(
      Vite_API_URL + `users/${data.user.id}`,
      data
    );
    callbacks.forEach((callback) => callback(response));
  } catch (error) {
    error_callbacks.forEach((callback) => callback(error));
  }
}

export async function deleteUser(data, callbacks = [], error_callbacks = []) {
  const newData = {
    user: {
      id: data.user.id,
      username: data.user.username,
      email: data.user.email,
      team_id: data.user.team_id,
      is_visible: false,
    },
  };
  try {
    const response = await axios.put(
      Vite_API_URL + `users/${data.user.id}`,
      newData
    );
    callbacks.forEach((callback) => callback(response));
  } catch (error) {
    error_callbacks.forEach((callback) => callback(error));
  }
}
