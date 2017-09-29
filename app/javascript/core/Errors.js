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
    return Object.keys(this.errors).length > 0;
  }

  record(errors) {
    this.errors = errors;
  }

  toArray() {
  	let arr = ['Error'];

  	for(let error in this.errors) {
			if (this.errors.hasOwnProperty(error)) {
				this.errors[error].forEach((msg) => {
					arr.push(error + ' ' + msg);
				});
			}
		}

		return arr;
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

export default Errors
