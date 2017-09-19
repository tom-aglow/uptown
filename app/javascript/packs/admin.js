import Vue from 'vue/dist/vue.js';

import axios from 'axios';
let token = document.getElementsByName('csrf-token')[0].getAttribute('content');
axios.defaults.headers.common['X-CSRF-Token'] = token;
axios.defaults.headers.common['Accept'] = 'application/json';

import VueRouter from 'vue-router';

import router from './routes.js';
import Form from '../core/Form';

window.Vue = Vue;
window.axios = axios;
window.Form = Form;

Vue.use(VueRouter);

document.addEventListener('turbolinks:load', () => {
  const app = new Vue({
    el: '#app',

    router,

    components: {
    },

    data: {
    },

    mounted() {
    },

    methods: {
    }
  })
});