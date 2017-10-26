<template>
	<canvas ref="chart"></canvas>
</template>

<script>
	import Chart from 'chart.js'

	export default {
		props: ['dataChart'],

		watch: {
			dataChart() {
				this.chartInit();
			}
		},

		methods: {
			chartInit() {
				const myChart = new Chart(this.$refs.chart.getContext('2d'), {
					type: 'bar',
					data: {
						labels: this.dataChart.labels,
						datasets: [{
							label: this.dataChart.options.label,
							data: this.dataChart.values,
							backgroundColor: this.dataChart.options.color,
							borderWidth: 1
						}]
					},
					options: {
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
