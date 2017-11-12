<template>
	<div class="sidebar">
		<div class="avatar" v-for="barber in barbers" :key="barber.id" :class="{active: id === barber.id}" @click="update(barber.id)">
			<img :src="'/assets/barbers/' + barber.avatar">
		</div>
	</div>
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
			update(id) {
				this.id = id;
				this.$emit('update', this.id);
			}
		}
	}

</script>
