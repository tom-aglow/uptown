//  import Vue library
import Vue from 'vue/dist/vue.js';
window.Vue = Vue;


//  include axios library
import axios from 'axios';

let token = document.getElementsByName('csrf-token')[0].getAttribute('content');
axios.defaults.headers.common['X-CSRF-Token'] = token;
axios.defaults.headers.common['Accept'] = 'application/json';

window.axios = axios;


//  Form core class
import Form from '../core/Form';
window.Form = Form;


//  flash messages
window.events = new Vue();
window.flash = function (type, ...messages) {
  window.events.$emit('flash', type, messages);
};
import Flash from '../views/components/Flash.vue';


//  declare the vue-router
import VueRouter from 'vue-router';
import router from './routes.js';
Vue.use(VueRouter);

//  include moment library
import moment from 'moment';
window.moment = moment;
moment.updateLocale('en', {
	week: {
		dow: 1,
	},
});


document.addEventListener('turbolinks:load', () => {
  const app = new Vue({
    el: '#app',

    router,

    components: { Flash },
  })
});
