<template>
    <tr>
        <td class="name">
            <input type="text" class="form-control form-control-sm" v-if="editing" v-model="service.name">
            <span v-else="editing" v-text="service.name"></span>
        </td>
        <td class="price">
            <input type="text" class="form-control form-control-sm" v-if="editing" v-model="service.price">
            <span v-else="editing" v-text="service.price"></span>
        </td>
        <td class="actions">
            <div class="form-group" v-if="editing">
                <div class="btn btn-xs btn-primary" @click="update">Save</div>
                <div class="btn btn-xs btn-secondary" @click="editing = false">Cancel</div>
            </div>
            <div v-else="editing">
                <button class="btn btn-warning btn-xs" @click="editing = true">Edit</button>
                <button class="btn btn-danger btn-xs" @click="destroy">Delete</button>
            </div>
        </td>
    </tr>
</template>

<script>
  export default {

    props: ['data'],

    data() {
      return {
        service: this.data,
        editing: false
      }
    },

    methods: {
      update() {
        axios.patch('/api/services/' + this.service.id, {
          service: this.service
        });
        this.editing = false;
        //  TODO flash message
      },

      destroy() {
        axios.delete('/api/services/' + this.service.id);

        //  fire an event for Services component
        this.$emit('deleted', this.service.id);
      }
    }


  }
</script>