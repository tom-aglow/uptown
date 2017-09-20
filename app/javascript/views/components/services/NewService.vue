<template>
    <tr>
        <td class="name">
            <input type="text" class="form-control form-control-sm" v-model="service.name">
        </td>
        <td class="price">
            <input type="text" class="form-control form-control-sm" v-model="service.price">
        </td>
        <td class="actions">
            <div class="btn btn-xs btn-info" @click="add">Add</div>
        </td>
    </tr>
</template>

<script>
  export default {

    data() {
      return {
        service: {
          name: '',
          price: ''
        }
      }
    },

    methods: {
        add() {
          axios.post('/api/services', { service: this.service })
              .then(response => {
                //  reset the service object
                this.service.name = '';
                this.service.price = '';

                //  fire an event for Services component
                this.$emit('created', response.data.data);

                // show flash message
                flash('New service was added');
              })
        }
    }


  }
</script>