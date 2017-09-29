<template>
	<select class="custom-select" v-model="id" @change="update">
		<option v-for="barber in barbers" v-text="barber.first_name" :value="barber.id" :key="barber.id"></option>
	</select>
</template>

<script>
	export default {

		data() {
			return {
				barbers: [],
				id: 1
			}
		},

		created() {
			axios.get('/api/barbers').then(data => { this.barbers = data.data });
		},

		methods: {
			update() {
				this.$emit('update', this.id);
			}
		}
	}

</script>
