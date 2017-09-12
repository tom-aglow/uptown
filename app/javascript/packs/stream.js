import Vue from 'vue/dist/vue.js';
import axios from 'axios';
import VueRouter from 'vue-router';

import router from './routes.js';

window.Vue = Vue;
window.axios = axios;

Vue.use(VueRouter);

document.addEventListener('turbolinks:load', () => {
  const app = new Vue({
    el: '#app',

    router,

    // render: h => h(Home),

    components: {
    },

    data: {
    },

    mounted() {
    },

    methods: {
    }
  })
})