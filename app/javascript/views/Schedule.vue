<template>
	<div class="block w-schedule">
		<h4>Set a schedule</h4>
		<date-picker class="date-box" v-once="" @update-date="updateDate" :date="date"></date-picker>
		<select class="custom-select" v-model="barber.id">
			<option v-for="item in barbers" v-text="item.first_name" :value="item.id"></option>
		</select>
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
				weekDates: [],
				barber: {
					id: 0
				},
				barbers: []
			}
		},

		created() {
			this.date = new Date();
			this.weekDates = this.getWeekDates(this.date);

			//	get list of all barbers and select the first one by default
			axios.get('/api/barbers').then(data => {
				this.barbers = data.data;
				this.barber.id = data.data[0].id;
			});

		},

		methods: {
			fetch() {
//				axios.get('/api/shifts/' + this.barber.id).then(this.refresh);
			},

			refresh ({data}) {
				this.data = data.data;
			},

			updateDate(date) {
				this.date = date;
			},

			getWeekDates(date) {
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
