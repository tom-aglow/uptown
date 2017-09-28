<template>
	<div>
		<div class="cell-header">{{ date | format_ddd }}</div>
		<div class="cell-header">{{ date | format_MMDD }}</div>
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

		watch: {
			data() {
				this.date = Object.keys(this.data)[0];
				this.shifts = this.data[Object.keys(this.data)[0]];
			}
		},

		mounted() {
		}

	}

</script>
