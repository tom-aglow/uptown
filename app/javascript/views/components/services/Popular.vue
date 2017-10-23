<template>
	<div class="block">
		<h4>Popular services</h4><br>
		<pie-chart :data-labels="services" :data-values="popularity"></pie-chart>
	</div>
</template>

<script>
	import PieChart from './popular/PieChart.vue'
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
