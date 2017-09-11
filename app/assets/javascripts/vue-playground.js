class Errors {
  constructor() {
    this.errors = {};
  }

  get(field) {
    if (this.errors[field]) {
      return field + ' ' + this.errors[field][0];
    }
  }

  has(field) {
    return this.errors.hasOwnProperty(field);
  }

  any() {
    return Object.keys(this.errors).length > 1;
  }

  record(errors) {
    this.errors = errors;
  }

  clear(id) {
    let field = id.split('_')[1];
    delete this.errors[field];
  }
}

class Form {
  reset() {

  }
}

new Vue({
  el: '#app',

  data: {
    skills: [],
    name: '',
    description: '',
    errors: new Errors()
  },

  mounted() {
    axios.get('/vue-playground/skills').then(response => this.skills = response.data)
  },

  methods: {
    onSubmit() {
      axios.post('/vue-playground/projects', {project: this.$data})
          .then(this.onSuccess)
          .catch(error => this.errors.record(error.response.data))
    },

    onSuccess() {
      console.log(response.message);
      this.name = '';
      this.description = '';
    }
  }
})