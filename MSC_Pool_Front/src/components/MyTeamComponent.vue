<template>
  <template v-if="user">
    <v-row v-if="true">
      <v-col cols="6">
        <v-select
          v-model="selectedIndex"
          label="Select Team"
          :items="teams"
          item-title="name"
          item-value="id"
        />
      </v-col>
      <v-col cols="6">
        <v-select
          v-model="selectedUser"
          :items="filteredUsers"
          item-title="username"
          item-value="id"
          label="Add user to Team"
          append-inner-icon="mdi-account-plus"
          @click:append-inner="addUserToTeam"
        />
      </v-col>
    </v-row>
    <v-row>
      <v-col cols="12">
        <v-card class="mx-auto" max-width="1080">
          <v-toolbar flat color="indigo">
            <v-btn icon="mdi-chart-sankey"></v-btn>
            <v-toolbar-title class="font-weight-light">
              Information about Team
            </v-toolbar-title>
            <v-spacer></v-spacer>

            <v-btn icon @click="isEditing = !isEditing">
              <v-fade-transition leave-absolute>
                <v-icon v-if="isEditing">mdi-close</v-icon>

                <v-icon v-else>mdi-pencil</v-icon>
              </v-fade-transition>
            </v-btn>
          </v-toolbar>
          <v-card-text>
            <v-row>
              <v-col cols="12">
                <Bar v-if="loaded" :data="chartData" :options="chartOptions" />
              </v-col>
            </v-row>
          </v-card-text>
          <v-divider />

          <v-divider />
          <v-spacer />
          <v-container>
            <v-row>
              <!-- <v-skeleton-loader
                  boilerplate
                  type="list-item-avatar"
                ></v-skeleton-loader> -->
              <v-col cols="6">
                <div v-if="planned_hours">
                  Planned Hours for this team :
                  <strong>{{ planned_hours }}</strong> H
                </div>
                <v-skeleton-loader v-else boilerplate type="text" />
              </v-col>
              <v-col cols="6">
                <div v-if="accomplished_hours">
                  Accomplished Hours for this team :
                  <strong>{{ accomplished_hours }}</strong> H
                </div>
                <v-skeleton-loader v-else boilerplate type="text" />
              </v-col>
            </v-row>
          </v-container>
        </v-card>
      </v-col>
    </v-row>

    <v-row>
      <v-col cols="12">
        <v-data-table
          :headers="headers"
          :items="memberships"
          :sort-by="[{ key: 'id', order: 'desc' }]"
          :sort-desc="sortDesc"
          class="elevation-1"
        >
          <template v-slot:top>
            <v-toolbar flat class="py-3">
              <v-toolbar-title class="text-h5"
                >Team Memberships</v-toolbar-title
              >
              <v-spacer></v-spacer>

              <v-dialog v-model="dialogDelete" max-width="500px">
                <v-card>
                  <v-card-title class="headline py-4 text-h5 grey lighten-2">
                    Confirm Removal
                  </v-card-title>
                  <v-card-text class="pt-4">
                    Are you sure you want to remove this user from the team?
                  </v-card-text>
                  <v-card-actions class="pa-4">
                    <v-spacer></v-spacer>
                    <v-btn text color="grey darken-1" @click="closeDelete">
                      Cancel
                    </v-btn>
                    <v-btn text color="red darken-1" @click="deleteItemConfirm">
                      Delete
                    </v-btn>
                  </v-card-actions>
                </v-card>
              </v-dialog>

              <v-dialog v-model="dialogManager" max-width="500px">
                <v-card>
                  <v-card-title class="headline py-4 text-h5 grey lighten-2">
                    Name New Manager
                  </v-card-title>
                  <v-card-text class="pt-4">
                    Make this user the team manager ?
                  </v-card-text>
                  <v-card-actions class="pa-4">
                    <v-spacer></v-spacer>
                    <v-btn text color="red red-1" @click="closeManagerDialog">
                      Cancel
                    </v-btn>
                    <v-btn
                      text
                      color="green green-2"
                      @click="managerDialogConfirm"
                    >
                      Confirm
                    </v-btn>
                  </v-card-actions>
                </v-card>
              </v-dialog>
            </v-toolbar>
          </template>

          <template v-slot:item.actions="{ item }">
            <span v-if="item.user_id === selectedTeam.manager_id">
              <v-chip class="ma-2" color="secondary"> Manager </v-chip>
            </span>
            <span v-else>
              <v-icon
                color="primary primary-2"
                class="mr-2"
                @click.stop="managerDialogItem(item)"
              >
                mdi-account-check
              </v-icon>
              <v-icon
                color="red darken-2"
                @click.stop="deleteItem(item)"
                class="mr-2"
              >
                mdi-account-minus
              </v-icon>
            </span>
          </template>

          <template v-slot:no-data>
            <v-btn color="primary" @click="initialize">Reload Data</v-btn>
          </template>
        </v-data-table>
        ``
      </v-col>
    </v-row>
    <v-row>
      <v-col cols="12">
        <v-data-table
          :headers="headersClocks"
          :items="teamClocks"
          class="elevation-1"
          :sort-by="[{ key: 'id', order: 'desc' }]"
          :sort-desc="sortDesc"
        >
          <template v-slot:top>
            <v-toolbar flat class="text-h5 py-3">
              <v-toolbar-title>Recent Clock ins and Clock outs</v-toolbar-title>
              <v-spacer></v-spacer>
            </v-toolbar>
            <v-divider></v-divider>
          </template>

          <template v-slot:item.status="{ item }">
            <v-chip
              class="ma-2"
              :color="item.status ? 'green' : 'red'"
              text-color="white"
              rounded
              style="
                width: 120px;
                height: 35px;
                text-align: center;
                display: flex;
                align-items: center;
                justify-content: center;
              "
            >
              <v-icon left size="small">
                {{ item.status ? "mdi-clock-in" : "mdi-clock-out" }}
              </v-icon>
              {{ item.status ? "clock-in" : "clock-out" }}
            </v-chip>
          </template>
        </v-data-table>
      </v-col>
    </v-row>
  </template>

  <template v-else>
    <v-skeleton-loader type="card" width="100%" />
  </template>
</template>

<script>
import { useUserStore } from "@/store/users";
import { Chart as ChartJS, ArcElement, Tooltip, Legend } from "chart.js";
import { Bar } from "vue-chartjs";

ChartJS.register(ArcElement, Tooltip, Legend);

import {
  deleteMembership,
  formatMembership,
  createMembership,
} from "../services/functions/memberships.js";

import { formatTeam, updateTeam } from "../services/functions/teams";
import { formatUser, ROLE_ENUM, updateUser } from "@/services/functions/user";

ChartJS.register(ArcElement, Tooltip, Legend);

export default {
  data: () => ({
    pointer: null,
    shifts: null,
    selectedTeam: null,
    dialogDelete: false,
    dialogManager: false,
    headers: [
      { title: "user ID", key: "user_id" },
      {
        title: "Username",
        align: "start",
        sortable: false,
        key: "username",
      },
      { title: "Email", key: "email" },
      { title: "Id", key: "id" },
      { title: "Actions", key: "actions", sortable: false },
    ],
    headersClocks: [
      {
        title: "id",
        key: "id",
      },
      {
        title: "Clock For ",
        key: "username",
      },
      {
        title: "Time",
        key: "bdate",
      },

      {
        title: "Type",
        key: "status",
      },
    ],
    selectedMembership: null,
    selectedUser: null,
    hasSaved: false,
    isEditing: null,
    selectedIndex: 1,
    clocks: [],
    user: {
      id: 1,
      username: "John Doe",
      email: "efpyi@example.com",
      role: "Manager",
    },
    currentTime: "",
    chartData: null,
    loaded: false,
    planned_hours: null,
    accomplished_hours: null,
    hourByMonth: null,
  }),
  props: {},
  created() {
    const store = useUserStore(); // Use the store within the component's context
    store.fetchUsers();
    store.fetchTeams();
    store.fetchMemberships();
    store.fetchSchedules();
    store.fetchAllClocks();
  },
  watch: {
    selectedIndex(newIndex) {
      this.updateUserFromIndex(newIndex);
    },
    teamSchedules(newSchedule) {
      this.planned_hours = newSchedule.reduce(
        (hours, schedule) => hours + schedule.hourDiff,
        0
      );
    },
    teamClocks(clocks) {
      // Sort the clocks by user_id and time to ensure chronological order for each user
      const sortedClocks = clocks.sort((a, b) => {
        return a.user_id - b.user_id || new Date(a.time) - new Date(b.time);
      });

      let shifts = [];
      let openShift = {};

      sortedClocks.forEach((clock) => {
        if (clock.status === true) {
          // Start of a new shift
          openShift = {
            start_time: clock.time,
            id_start_time: clock.id,
            user_id: clock.user_id,
          };
        } else if (openShift.user_id === clock.user_id && !openShift.end_time) {
          // End of a shift
          openShift.end_time = clock.time;
          openShift.id_end_time = clock.id;
        }
      });

      // Now we handle shifts that have not been closed
      shifts = sortedClocks.map((clock) => {
        // Find the corresponding end clock or create a default one
        let endClock = sortedClocks.find(
          (c) =>
            c.user_id === clock.user_id &&
            c.status === false &&
            c.time > clock.time
        );
        let endTime = endClock
          ? endClock.time
          : new Date(
              new Date(clock.time).getTime() + 60 * 60 * 1000
            ).toISOString();

        // Calculate the hour difference
        const startTime = new Date(clock.time);
        const endTimeDate = new Date(endTime);
        const hourDiff = (endTimeDate - startTime) / (1000 * 60 * 60); // Difference in hours

        return {
          start_time: clock.time,
          id_start_time: clock.id,
          end_time: endTime,
          id_end_time: endClock ? endClock.id : null, // If there is no end clock, id will be null
          user_id: clock.user_id,
          hourDiff: hourDiff,
        };
      });
      this.shifts = shifts;
      this.accomplished_hours = Math.round(
        shifts.reduce((hours, s) => hours + s.hourDiff, 0)
      );
      return shifts;
    },
  },
  computed: {
    chartOptions() {
      return {
        responsive: true,
        maintainAspectRatio: false,
      };
    },
    users() {
      const store = useUserStore();
      return store.users;
    },
    filteredUsers() {
      const store = useUserStore();
      const users = store.users;
      const memberships = store.getMembershipsForTeam(this.selectedIndex);
      // Get a Set of user_ids that have memberships
      const membershipUserIds = new Set(
        memberships.map((membership) => membership.user_id)
      );
      // Filter out users who already have a membership
      const returnData = users.filter(
        (user) => !membershipUserIds.has(user.id)
      );
      return returnData;
    },
    usersInTeam() {
      const store = useUserStore();
      const users = store.users;
      const memberships = store.getMembershipsForTeam(this.selectedIndex);
      // Get a Set of user_ids that have memberships
      const membershipUserIds = new Set(
        memberships.map((membership) => membership.user_id)
      );
      // Filter in users who already have a membership
      const returnData = users.filter((user) => membershipUserIds.has(user.id));
      return returnData;
    },
    teamSchedules() {
      const store = useUserStore(); // Assuming you have a similar store for schedules
      const schedules = store.schedules;
      const usersInThisTeam = this.usersInTeam; // Get the users in the team

      const userIDsInTeam = new Set(usersInThisTeam.map((user) => user.id));

      const teamSchedules = schedules
        .filter((schedule) => userIDsInTeam.has(schedule.user_id))
        .map((schedule) => {
          const startTime = new Date(schedule.start_time);
          const endTime = new Date(schedule.end_time);
          const hourDiff = (endTime - startTime) / (1000 * 60 * 60); // Difference in hours
          return {
            ...schedule,
            hourDiff: parseFloat(hourDiff.toFixed(2)), // Rounds the hour difference to two decimal places
          };
        });
      return teamSchedules;
    },
    teamClocks() {
      const store = useUserStore();
      const clocks = store.clocks;
      const usersInThisTeam = this.usersInTeam; // This should be an array of user objects.
      const userIDsInTeam = new Set(usersInThisTeam.map((user) => user.id));

      let teamClocks = clocks.filter((clock) =>
        userIDsInTeam.has(clock.user_id)
      );

      teamClocks = teamClocks.map((clock) => {
        const user = usersInThisTeam.find((user) => user.id === clock.user_id);
        const dateObj = new Date(clock.time);
        // Format the date to "JJ MM AAAA hh:mm"
        const bdate = `${dateObj.getDate().toString().padStart(2, "0")}/${
          dateObj.getMonth() + 1
        }/${dateObj.getFullYear()} ${dateObj
          .getHours()
          .toString()
          .padStart(2, "0")}:${dateObj
          .getMinutes()
          .toString()
          .padStart(2, "0")}`;
        // Return a new object that includes all properties of the clock, along with the username and formatted bdate
        return { ...clock, username: user ? user.username : undefined, bdate };
      });

      return teamClocks;
    },

    teams() {
      const store = useUserStore();
      const teams = store.teams;
      // eslint-disable-next-line vue/no-side-effects-in-computed-properties
      this.selectedTeam = teams.find((t) => t.id == this.selectedIndex);
      return teams;
    },
    memberships() {
      const store = useUserStore();
      const memberships = store.getMembershipsForTeam(this.selectedIndex);
      const users = store.users;
      const returnData = memberships.map((membership) => {
        const user = users.find((user) => user.id === membership.user_id);
        return {
          username: user ? user.username : "N/A", // 'N/A' or some fallback if user is not found
          user_id: membership.user_id,
          email: user ? user.email : "N/A", // 'N/A' or some fallback if user is not found
          id: membership.id,
        };
      });
      return returnData;
    },
  },
  mounted() {
    this.loaded = false;
  },
  methods: {
    // loadChart() {
    //   try {
    //     console.log("LOAD CHART", this.teamSchedules);
    //     this.chartData = {
    //       labels: ["ABSENT", "PRESENT"], // Remplacez "label" par le nom de la propriété qui contient les libellés
    //       datasets: [
    //         {
    //           backgroundColor: [
    //             "rgba(255, 99, 132, 0.2)",
    //             "rgba(75, 192, 192, 0.2)",
    //           ],
    //           borderColor: ["rgba(255, 99, 132, 1)", "rgba(75, 192, 192, 1)"],
    //           borderWidth: 2,
    //           data: [50, 50], // Remplacez "status" par le nom de la propriété qui contient les données
    //         },
    //       ],
    //     };

    //     this.loaded = true;
    //   } catch (e) {
    //     console.error(e);
    //   }
    // },
    managerDialogItem(item) {
      console.log("Manager Item", item);
      this.pointer = item;
      this.dialogManager = true;
    },
    deleteItem(item) {
      console.log(item);
      this.selectedMembership = item.id;
      this.editedIndex = this.users.indexOf(item);
      this.editedItem = Object.assign({}, item);
      this.dialogDelete = true;
    },
    closeDelete() {
      this.dialogDelete = false;
      this.selectedMembership = null;
    },
    closeManagerDialog() {
      this.dialogManager = false;
    },

    deleteItemConfirm() {
      deleteMembership(this.selectedMembership, [this.refreshData]);
      this.closeDelete();
    },
    managerDialogConfirm() {
      this.changeUserRole(this.pointer);
      // deleteMembership(this.selectedMembership, [this.refreshData]);
      this.closeManagerDialog();
      this.pointer = null;
    },

    refreshData() {
      const store = useUserStore();
      store.fetchTeams();
      store.fetchUsers();
      store.fetchMemberships();
    },
    addUserToTeam() {
      console.log(this.selectedTeam);

      // try {
      //   const formData = formatMembership({
      //     user_id: this.selectedUser,
      //     team_id: this.selectedIndex,
      //   });
      //   createMembership(formData, [this.refreshData]);
      //   this.selectedUser = null;
      // } catch (e) {
      //   console.error(e);
      // }
    },

    changeUserRole({ user_id }) {
      if (this.selectedTeam.manager_id) {
        const concernedUser = this.users.find(
          (u) => u.id === this.selectedTeam.manager_id
        );
        const user = formatUser(concernedUser, ROLE_ENUM.user, true, false);
        updateUser(user, [this.refreshData]);
      }
      (() => {
        const team = formatTeam({ ...this.selectedTeam, user_id: user_id });
        updateTeam(team, [this.refreshData]);
      })();

      // Update role to manager
      (() => {
        const concernedUser = this.users.find((u) => u.id === user_id);
        const user = formatUser(concernedUser, ROLE_ENUM.manager, true, false);
        updateUser(user, [this.refreshData]);
        console.log(user);
      })();
    },
    updateUserFromIndex(index) {
      this.selectedIndex = index;
      this.selectedTeam = this.teams.find((t) => t.id == index);
    },
    save() {
      this.isEditing = !this.isEditing;
      this.hasSaved = true;
    },
  },
  components: { Bar },
};
</script>
