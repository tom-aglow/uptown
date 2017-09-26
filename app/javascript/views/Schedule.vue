<template>
	<div class="block w-schedule">
		<h4>Set a schedule</h4>
		<date-picker class="date-box" v-once="" @update-date="updateDate" :date="date"></date-picker>
		<select class="custom-select" v-model="barber.id">
			<option v-for="item in barbers" v-text="item.first_name" :value="item.id"></option>
		</select>
		<div class="table">
			<div></div>
			<div v-for="day in getWeekDaysNames()" v-text="day" class="day-name"></div>
			<div>Time</div>
			<div v-for="day in weekDates" v-text="formatDate(day)" class="day"></div>
			<div v-for="spot in schedule" v-text="spot.text" :class="spot.css"></div>
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
				date: null,
				weekDates: [],
				barber: { id: 0 },
				barbers: [],
				shifts: null,
				times: this.setTimes(),
				schedule: null
			}
		},

		created() {
			//	get today's date and all days of current week
			this.date = new Date();
			this.weekDates = this.getWeekDates(this.date);

			//	get list of all barbers and select the first one by default
			axios.get('/api/barbers')
				.then(data => {
					this.barbers = data.data;
					this.barber.id = data.data[0].id;
				})
				.then(this.fetch);

		},

		methods: {
			fetch() {
				axios.get('/api/shifts/' + this.barber.id + '/' + this.date).then(this.refresh).then(this.setSchedule);
			},

			refresh ({data}) {
				this.shifts = data.data;
			},

			updateDate(date) {
				this.date = date;
			},

			setSchedule() {
				let schedule = [];

				for (let time of this.times) {
					//  first element in a row = time
					schedule.push({css: 'time', text: this.formatAMPM(time)});

					for (let weekDate of this.weekDates) {

						//	set default class
						let cssClass = ['bg-secondary', 'disabled'];

						// change class if there is scheduled shift at this date and time
						this.shifts.forEach(shift => {
							if (shift.date === moment(weekDate).format('YYYY-MM-DD') && shift.time === time) {
								 cssClass = (shift.is_free) ? 'bg-success' : 'bg-danger';
							}
						});

						//	add element to aggregated array
						schedule.push({css: [cssClass, 'cell'], text: ''});
					}
				}

				this.schedule = schedule;
			},

			getWeekDates(date) {
				let startDate = moment(date).weekday(0);
				let dates = [];

				for (let i = 0; i < 7; i++) {
					dates.push(moment(startDate).add(i, 'd'));
				}

				return dates;
			},

			formatDate(date) {
				return moment(date).format('MM/DD');
			}
		}
	}

</script>
