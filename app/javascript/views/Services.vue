<template>
	<div class="block">
		<h4>Services</h4>
		<table class="table table-striped table-sm services">
			<tr>
				<th class="name">Name</th>
				<th class="price">Price</th>
				<th class="actions"></th>
			</tr>
			<service v-for="(service, index) in items" :data="service" :key="service.id" @deleted="remove(index)"></service>
			<new-service @created="add"></new-service>
		</table>
	</div>
</template>

<script>
	import Service from './components/services/Service.vue'
	import NewService from './components/services/NewService.vue'

	export default {
		components: { Service, NewService },

		data() {
			return {
				items: false
			}
		},

		created() {
			this.fetch();
		},

		methods: {
			fetch() {
				axios.get('/api/services').then(this.refresh).then(this.setSchedule);
			},

			refresh ({data}) {
				this.items = data.data;
			},

			add(item) {
				this.items.push(item);
				this.$emit('added');
			},

			remove(index) {
				this.items.splice(index, 1);
				this.$emit('removed');
			}
		}
	}
</script>
