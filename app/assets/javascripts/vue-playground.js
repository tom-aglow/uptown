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
    //  clone the object
    let data = Object.assign({}, this);

    delete data.originalData;
    delete data.errors;

    return data;
  }

  reset() {
    for (let field in this.originalData) {
      this[field] = '';
    }
  }

  submit(requestType, url) {
    axios[requestType.toLowerCase()](url, {project: this.data()})
        .then(this.onSuccess.bind(this))
        .catch(this.onFail.bind(this))
  }

  onSuccess(response) {
    console.log(response.data.message);
    this.errors.clear();
    this.reset();
  }

  onFail(error) {
    this.errors.record(error.response.data)
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
      this.form.submit('POST', '/vue-playground/projects');
    }
  }
})