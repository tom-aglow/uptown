<template>
    <tr>
        <td class="name">
            <input type="text" class="form-control form-control-sm" v-if="editing" v-model="service.name">
            <span v-else="editing" v-text="service.name"></span>
        </td>
        <td class="price" v-text="service.price"></td>
        <td class="actions">
            <div class="form-group" v-if="editing">
                <div class="btn btn-xs btn-primary" @click="update">Save</div>
                <div class="btn btn-xs btn-secondary" @click="editing = false">Cancel</div>
            </div>
            <button class="btn btn-info btn-xs" v-else="editing" @click="editing = true">Edit</button>
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
        axios.patch('/api/v-services/' + this.service.id, {
          service: this.service
        });
        this.editing = false;
        //  TODO flash message
      }
    }


  }
</script>