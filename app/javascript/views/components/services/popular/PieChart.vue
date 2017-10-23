<template>
	<canvas width="600" height="400" ref="chart"></canvas>
</template>

<script>
	import Chart from 'chart.js'
	import googleColors from '../../../../core/colors'

	export default {
		props: ['dataLabels', 'dataValues', 'dataShade'],

		computed: {
			colors() {
				const result = [];
				Object.keys(googleColors).forEach((color) => {
					if (googleColors[color][this.dataShade] !== undefined) {
						result.push(googleColors[color][this.dataShade]);
					}
				});
				return result;
			}
		},

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
							label: '# of Votes',
							data: this.dataValues,
							backgroundColor: this.colors.slice(0, this.dataValues.length),
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
