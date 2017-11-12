<template>
	<div>
		<div class="w-schedule-container">
			<barber @update="updateBarberID"></barber>
			<div class="block w-schedule">
				<h4>Set a schedule</h4>
				<date-picker class="date-box" @update-date="updateDate" :date="date" :data-id="'schedule'"></date-picker>
				<div class="table">
					<div>
						<div class="cell-header"></div>
						<div class="cell-header"></div>
						<div v-for="time in times" class="cell-side">{{ time | format_AMPM }}</div>
					</div>
					<shift-day v-for="day in weekDates" :data="day" :key="day | format_MMDD"></shift-day>
				</div>
				<div class="legend">
					<div class="legend-row">
						<div class="cell-sample cell-default"></div>
						<div> - off</div>
					</div>
					<div class="legend-row">
						<div class="cell-sample cell-free"></div>
						<div> - available</div>
					</div>
					<div class="legend-row">
						<div class="cell-sample cell-busy"></div>
						<div> - booked</div>
					</div>
				</div>
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
				//	start date of selected week
				let startDate = moment(date).weekday(0);

				//	dates array with all shifts spots for current week
				let dates = [];

				//	save shifts object to local variable
				let shifts = this.weekShifts;

				//	for each day of week
				for (let i = 0; i < 7; i++) {

					//	object with all spots for current day
					let obj = {};

					//	current date string value which is used as key for the object
					let curDate = moment(startDate).add(i, 'd').format('YYYY-MM-DD');

					if (shifts !== null && shifts.hasOwnProperty(curDate)) {
						//	if there is already at least one shift for current date
						obj[curDate] = {};

						//	loop through time spots of the day
						this.times.forEach((time) => {

							if(shifts[curDate].hasOwnProperty(time)) {
								//	if there is shift for the time spot, add shift object to the parent object with time key
								obj[curDate][time] = shifts[curDate][time];
							} else {
								//	...	if not then create a dummy time spot
								obj[curDate][time] = { "date": curDate, "time": time, "barber_id": this.barber.id };
							}
						});

					} else {
						//	if there is no shifts at all for the date
						obj[curDate] = {};

						//	fill object with dummy objects for each time spot
						this.times.forEach((time) => {
							obj[curDate][time] = { "date": curDate, "time": time, "barber_id": this.barber.id  };
						});
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
