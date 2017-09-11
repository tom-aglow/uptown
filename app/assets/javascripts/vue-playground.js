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
    if (id) {
      let field = id.split('_')[1];
      delete this.errors[field];
    } else {
      this.errors = {}
    }
  }
}

class Form {
  constructor(data) {
    this.originalData = data;

    for (let field in data) {
      this[field] = data[field];
    }

    this.errors = new Errors()
  }

  data() {
    let data = {};

    for (let property in this.originalData) {
      data[property] = this[property];
    }

    return data;
  }

  reset() {
    for (let field in this.originalData) {
      this[field] = '';
    }
    this.errors.clear();
  }

  submit(requestType, url) {
    return new Promise((resolve, reject) => {
      axios[requestType.toLowerCase()](url, {project: this.data()})
          .then(response => {
            this.onSuccess(response.data);
            resolve(response.data);
          })
          .catch(error => {
            this.onFail(error.response.data);
            reject(error.response.data);
          })
    })
  }

  onSuccess(data) {
    console.log(data.message);
    this.reset();
  }

  onFail(errors) {
    this.errors.record(errors)
  }
}

new Vue({
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