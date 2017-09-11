new Vue({
  el: '#app',

  data: {
    skills: []
  },

  mounted() {
    axios.get('/vue-playground/skills').then(response => this.skills = response.data)
  }
})