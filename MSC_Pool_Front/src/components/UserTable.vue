<template>
  <v-data-table :headers="headers" :items="users" class="elevation-1 pa-6">
    <template v-slot:top>
      <v-toolbar flat>
        <v-toolbar-title>My Team</v-toolbar-title>
        <v-divider class="mx-4" inset vertical></v-divider>
        <v-spacer></v-spacer>
        <v-dialog v-model="dialog" max-width="500px">
          <template v-slot:activator="{ props }">
            <v-btn color="primary" dark class="mb-2" v-bind="props">
              New Item
            </v-btn>
          </template>
          <v-card>
            <v-card-title>
              <span class="text-h5">{{ formTitle }}</span>
            </v-card-title>

            <v-card-text>
              <v-container>
                <v-row>
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field
                      v-model="editedItem.name"
                      label="User name"
                    ></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field
                      v-model="editedItem.email"
                      label="email"
                    ></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6" md="4"> </v-col>
                </v-row>
              </v-container>
            </v-card-text>

            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn color="blue-darken-1" variant="text" @click="close">
                Cancel
              </v-btn>
              <v-btn color="blue-darken-1" variant="text" @click="save">
                Save
              </v-btn>
            </v-card-actions>
          </v-card>
        </v-dialog>
        <v-dialog v-model="dialogDelete" max-width="500px">
          <v-card>
            <v-card-title class="text-h5"
              >Are you sure you want to delete this item?</v-card-title
            >
            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn color="blue-darken-1" variant="text" @click="closeDelete"
                >Cancel</v-btn
              >
              <v-btn
                color="blue-darken-1"
                variant="text"
                @click="deleteItemConfirm"
                >OK</v-btn
              >
              <v-spacer></v-spacer>
            </v-card-actions>
          </v-card>
        </v-dialog>
      </v-toolbar>
    </template>
    <template v-slot:item.actions="{ item }">
      <v-icon size="small" class="me-2" @click="editItem(item)">
        mdi-pencil
      </v-icon>
      <v-icon size="small" @click="deleteItem(item)"> mdi-delete </v-icon>
    </template>
    <template v-slot:no-data>
      <v-btn color="primary" @click="initialize"> Reset </v-btn>
    </template>
  </v-data-table>
</template>
<script>
import { useUserStore } from "../store/users";

export default {
  data: () => ({
    dialog: false,
    dialogDelete: false,
    headers: [
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
    editedIndex: -1,
    editedItem: {
      name: "",
      email: "",
    },
    defaultItem: {
      name: "",
      email: "",
    },
  }),

  computed: {
    users() {
      const store = useUserStore();
      // Use the store within the component's context
      return store.users;
    },
    formTitle() {
      return this.editedIndex === -1 ? "New Item" : "Edit Item";
    },
  },
  // Dialog for create new user
  watch: {
    dialog(val) {
      val || this.close();
    },
    dialogDelete(val) {
      val || this.closeDelete();
    },
  },

  created() {
    const store = useUserStore(); // Use the store within the component's context
    store.fetchUsers();
  },

  // ... other component options
};

// Method for the CRUD user

// methods: {
//   initialize () {
//     this.users = [
//     users
//     ]
//   },

//   editItem (item) {
//     this.editedIndex = this.users.indexOf(item)
//     this.editedItem = Object.assign({}, item)
//     this.dialog = true
//   },

//   deleteItem (item) {
//     this.editedIndex = this.users.indexOf(item)
//     this.editedItem = Object.assign({}, item)
//     this.dialogDelete = true
//   },

//   deleteItemConfirm () {
//     this.users.splice(this.editedIndex, 1)
//     this.closeDelete()
//   },

//   close () {
//     this.dialog = false
//     this.$nextTick(() => {
//       this.editedItem = Object.assign({}, this.defaultItem)
//       this.editedIndex = -1
//     })
//   },

//   closeDelete () {
//     this.dialogDelete = false
//     this.$nextTick(() => {
//       this.editedItem = Object.assign({}, this.defaultItem)
//       this.editedIndex = -1
//     })
//   },

//   save () {
//     if (this.editedIndex > -1) {
//       Object.assign(this.users[this.editedIndex], this.editedItem)
//     } else {
//       this.users.push(this.editedItem)
//     }
//     this.close()
//   },
// },
</script>
