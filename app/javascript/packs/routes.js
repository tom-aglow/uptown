import VueRouter from 'vue-router';

import Dashboard from '../views/Dashboard.vue';
import Services from '../views/Services.vue';
import Schedule from '../views/Schedule.vue';

let routes = [
  {
    path: '/',
    component: Dashboard
  },
  {
    path: '/services',
    component: Services
  },
	{
		path: '/schedule',
		component: Schedule
	},
];

export default new VueRouter({
  routes,
  linkActiveClass: 'active'
});
