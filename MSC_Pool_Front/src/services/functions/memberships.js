import axios from "axios";
import { Vite_API_URL } from "../url";

export function formatMembership(data) {
  const formData = {
    membership: {},
  };
  formData.membership.id = data.id || null;
  formData.membership.user_id = data.user_id;
  formData.membership.team_id = data.team_id;

  return formData;
}
export async function createMembership(
  data,
  callbacks = [],
  error_callbacks = []
) {
  try {
    const response = await axios.post(Vite_API_URL + "memberships", data);
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

export async function deleteMembership(
  id,
  callbacks = [],
  error_callbacks = []
) {
  try {
    const response = await axios.delete(Vite_API_URL + `memberships/${id}`);
    callbacks.forEach((callback) => callback(response));
  } catch (error) {
    error_callbacks.forEach((callback) => callback(error));
  }
}
