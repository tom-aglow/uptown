<template>
	<canvas :width="dataOptions.width" :height="dataOptions.height" ref="chart"></canvas>
</template>

<script>
	import Chart from 'chart.js'
	import colors from '../../../core/colors'

	export default {
		props: ['dataLabels', 'dataValues', 'dataOptions'],

		watch: {
			dataValues() {
				this.chartInit();
			}
		},

		methods: {
			chartInit() {
				const myChart = new Chart(this.$refs.chart.getContext('2d'), {
					type: 'pie',
					data: {
						labels: this.dataLabels,
						datasets: [{
							label: this.dataOptions.label,
							data: this.dataValues,
							backgroundColor: colors.slice(0, this.dataValues.length),
							borderWidth: 1
						}]
					},
					options: {
						hover: {

						},
						animation: {
							duration: 500
						},
						legend: {
							position: 'bottom',
							fontFamily: "Textbook, 'Open Sans', Sans-Serif"
						}
					}
				})
			}
		}
	}
</script>
