export default {

	methods: {

		setTimes() {
			let arr = [];
			for (let i = 10; i <= 19; i++) {
				arr.push(i + ':00:00');
			}
			return arr;
		},

		formatAMPM(time) {
			let hours = +time.split(':')[0];
			let ampm = hours >= 12 ? 'PM' : 'AM';
			hours = hours % 12;
			hours = hours ? hours : 12; // the hour '0' should be '12'
			hours = (hours < 10) ? '0' + hours : hours;
			return hours + ':00 ' + ampm;
		},

		getWeekDaysNames() {
			let weekDays = [];
			for (let i = 0; i < 7; i++) {
				weekDays.push(moment().weekday(i).format('ddd'));
			}
			return weekDays;
		}
	}
}
