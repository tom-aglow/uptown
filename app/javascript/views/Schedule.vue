<template>
	<div class="block w-schedule">
		<h4>Set a schedule</h4>
		<date-picker class="date-box" v-once="" @update-date="updateDate" :date="date"></date-picker>
		<div class="table">
			<div>Time</div>
			<div v-for="day in weekDates" v-text="day"></div>
		</div>
	</div>
</template>

<script>
	import DatePicker from './components/Datepicker.vue'
	import TimeMixin from './mixins/time-mixin.js'

	export default {
		components: { DatePicker },

		mixins: [TimeMixin],

		data() {
			return {
				date: false,
				weekDates: []
			}
		},

		created() {
			this.date = new Date();
			this.weekDates = this.getWeekDates(this.date);
		},

		methods: {
			updateDate(date) {
				this.date = date;
			},

			getWeekDates(date) {
				console.log(date);
				let startDate = moment(date).day(0);
				let dates = [];

				for (let i = 0; i < 7; i++) {
					dates.push(moment(startDate).add(i, 'd').format('MM/DD'));
				}

				return dates;
			}
		}
	}

</script>
