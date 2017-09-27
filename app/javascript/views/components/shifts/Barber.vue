<template>
	<select class="custom-select">
		<option v-for="barber in barbers" v-text="barber.first_name" :value="barber.id" :key="barber.id"></option>
	</select>
</template>

<script>
	export default {

		data() {
			return {
				barbers: [],
			}
		},

		created() {
			axios.get('/api/barbers').then(data => { this.barbers = data.data });
		},

		methods: {
		}
	}

</script>
