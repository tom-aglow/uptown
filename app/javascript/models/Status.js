class Status {
  static all(then) {
    return axios.get('/vue-playground/stream/statuses')
        .then(({data}) => then(data));
  }
}

export default Status;