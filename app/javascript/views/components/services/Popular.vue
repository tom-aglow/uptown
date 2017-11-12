<template>
	<div class="block v-popular-services">
		<h4>Popular services</h4><br>
		<pie-chart :data-labels="services" :data-values="popularity" :data-options="{label: '# of cuts', width: 600, height: 400}"></pie-chart>
	</div>
</template>

<script>
	import PieChart from '../charts/PieChart.vue'
	import collection from '../../../core/collection'

	export default {
		components: { PieChart },

		mixins: [collection],

		data() {
			return {
				page: '/api/services/popular'
			}
		},

		computed: {
			popularity() {
				return this.items.map((item) => item.popularity)
			},

			services() {
				return this.items.map((item) => item.name)
			}
		}
	}
</script>
