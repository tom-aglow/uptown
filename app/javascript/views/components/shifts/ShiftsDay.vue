<template>
	<div>
		<div class="cell-header">{{ formatDayNameForTitle(date) }}</div>
		<div class="cell-header">{{ formatDateForTitle(date) }}</div>
		<shift v-for="time in times" :data="shifts[time]"></shift>
	</div>
</template>

<script>
	import Shift from './Shift.vue';

	import TimeMixin from '../../mixins/time-mixin.js';

	export default {

		props: ['data'],

		mixins: [TimeMixin],

		components: { Shift },

		data(){
			return {
				date: Object.keys(this.data)[0],
				shifts: this.data[Object.keys(this.data)[0]],
				times: this.setTimes(),

			}
		},

		mounted() {
		},

		methods: {

			formatDateForTitle(date) {
				return moment(date).format('MM/DD');
			},

			formatDayNameForTitle(date) {
				return moment(date).format('ddd');
			}
		}

	}

</script>
