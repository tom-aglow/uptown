<template>
	<div class="w-booking-trend block">
		<h4>Booking dynamic</h4>
		<bar-chart :data-chart="dataChart"></bar-chart>
	</div>
</template>

<script>
	import collection from '../../../core/collection'
	import BarChart from '../charts/BarChart.vue'

	export default {
		mixins: [collection],

		components: { BarChart },

		data() {
			return {
				page: '/api/requisitions/trend'
			}
		},

		computed: {
			dataChart() {
				return {
					values: Object.values(this.items),
					labels: Object.keys(this.items),
					options: {
						label: '# of reservations',
						color: '#ED4795'
					}
				}
			}
		}
	}
</script>
