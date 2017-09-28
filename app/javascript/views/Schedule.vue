<template>
	<div>
		<div class="block w-schedule">
			<h4>Set a schedule</h4>
			<date-picker class="date-box" v-once="" @update-date="updateDate" :date="date"></date-picker>
			<barber @update="updateBarberID"></barber>
			<div class="table">
				<div>
					<div class="cell-header"></div>
					<div class="cell-header"></div>
					<div v-for="time in times" class="cell-side">{{ time | format_AMPM }}</div>
				</div>
				<shift-day v-for="day in weekDates" :data="day"></shift-day>
			</div>
		</div>

	</div>

</template>

<script>
	import DatePicker from './components/Datepicker.vue'
	import ShiftDay from './components/shifts/ShiftsDay.vue'
	import Barber from './components/shifts/Barber.vue'

	import TimeMixin from './mixins/time-mixin.js'

	export default {

		components: { DatePicker, ShiftDay, Barber },

		mixins: [TimeMixin],

		data() {
			return {
				date: null,
				weekDates: [],
				barber: { id: 1 },
				times: this.setTimes(),

				weekShifts: null
			}
		},

		created() {
			this.date = new Date();
			this.fetch();
		},

		methods: {
			fetch() {
				axios.get('/api/shifts/' + this.barber.id + '/' + this.date).then(this.refresh);
			},

			refresh ({data}) {
				this.weekShifts = data.data;
				this.weekDates = this.getWeekDates(this.date);
			},

			updateDate(date) {
				this.date = date;
			},

			getWeekDates(date) {
				let startDate = moment(date).weekday(0);
				let dates = [];

				for (let i = 0; i < 7; i++) {
					let obj = {};
					let curDate = moment(startDate).add(i, 'd').format('YYYY-MM-DD');
					if (this.weekShifts !== null && this.weekShifts.hasOwnProperty(curDate)) {
						obj[curDate] = this.weekShifts[curDate];
					} else {
						obj[curDate] = [];
					}

					dates.push(obj);
				}

				return dates;
			},

			updateBarberID(id) {
				this.barber.id = id;
				this.fetch();
			},

			updateDate(date) {
				if(moment(this.date).week() !== moment(date).week()) {
					this.date = date;
					this.fetch();
				} else {
					this.date = date;
				}
			}

		}
	}

</script>
