import Vue from 'vue/dist/vue.js'
import axios from 'axios'

import Form from '../core/Form'



document.addEventListener('turbolinks:load', () => {
  const app = new Vue({
    el: '#app',

    data: {
      skills: [],
      form: new Form({
        name: '',
        description: '',
      }),
    },

    mounted() {
      axios.get('/vue-playground/skills').then(response => this.skills = response.data)
    },

    methods: {
      onSubmit() {
        this.form.submit('POST', '/vue-playground/projects')
            .then(data => console.log(data))
            .catch(errors => console.log(errors));
      }
    }
  })
})