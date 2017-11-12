<template>
	<div class="block v-services">
		<h4>Services</h4>
		<table class="table table-striped table-sm">
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
	import Service from './list/Service.vue'
	import NewService from './list/NewService.vue'

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
				flash('Success', 'New service was created');
			},

			remove(index) {
				this.items.splice(index, 1);
			}
		}
	}
</script>
