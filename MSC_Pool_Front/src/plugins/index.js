/**
 * plugins/index.js
 *
 * Automatically included in `./src/main.js`
 */

// Plugins
import vuetify from './vuetify'
import router from '../router'
import pinia from '../store'
import ganttastic from '@infectoone/vue-ganttastic'
import VCalendar from 'v-calendar';
import 'v-calendar/style.css';

export function registerPlugins (app) {
  app
    .use(vuetify)
    .use(router)
    .use(pinia)
    .use(ganttastic)
    .use(VCalendar, {})
}
