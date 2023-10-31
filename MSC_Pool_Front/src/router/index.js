// Composables
import { createRouter, createWebHistory } from 'vue-router'
import DashBoard from '../views/DashBoard.vue'
import UserProfil from '../views/UserProfil.vue'
import MyCalendar from '../views/MyCalendar.vue'
import MyTeam from '../views/MyTeam.vue'
const routes = [
  {
    path: '/',
    component: DashBoard,
  },
  {
    path: '/profil',
    component: UserProfil,
  },
  {
    path: '/calendar',
    component: MyCalendar,
  },
  {
    path: '/myTeam',
    component: MyTeam,
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
})

export default router
