<template>
	<tr>
		<td class="name">
			<input type="text" class="form-control form-control-sm" v-model="service.name">
		</td>
		<td class="price">
			<input type="text" class="form-control form-control-sm" v-model="service.price">
		</td>
		<td class="actions">
			<div class="btn btn-xs btn-primary" @click="add">Add</div>
		</td>
	</tr>
</template>

<script>
  export default {

    data() {
      return {
        service: new Form ({
          name: '',
          price: ''
        })
      }
    },

    methods: {
			add() {
				this.service.submit('post', '/api/services', 'service')
					.then(data => this.$emit('created', data.data))
					.catch(() => flash.apply(null, this.service.errors.toArray()));
			}
    }


  }
</script>
