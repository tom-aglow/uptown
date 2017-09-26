import VueRouter from 'vue-router';

import Dashboard from '../views/Dashboard.vue';
import Services from '../views/Services.vue';

let routes = [
  {
    path: '/',
    component: Dashboard
  },
  {
    path: '/services',
    component: Services
  },
];

export default new VueRouter({
  routes,
  linkActiveClass: 'active'
});
