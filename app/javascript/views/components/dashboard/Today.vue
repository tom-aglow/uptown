<template>
    <div class="w-today">
				<h4>Day schedule</h4>
        <date-picker v-once="" @update-date="updateDate" :date="date"></date-picker>
        <div class="table">
						<div></div>
						<div v-for="barber in data" class="avatar">
							<img :src="'/assets/barbers/' + barber.avatar">
						</div>
            <div></div>
            <div v-for="barber in data" v-text="barber.first_name" class="names"></div>
            <div v-for="spot in schedule" v-text="spot.text" :class="spot.css"></div>
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
</template>

<script>
    import DatePicker from '../Datepicker.vue'
    import TimeMixin from '../../mixins/time-mixin.js'

    export default {

      components: { DatePicker },

			mixins: [TimeMixin],

      data() {
        return {
          data: false,
          times: this.setTimes(),
          schedule: false,
					date: new Date()
        }
      },

      created() {
        this.fetch();
      },

      methods: {
        fetch() {
          axios.get('/api/w-today/' + this.date).then(this.refresh).then(this.setSchedule);
        },

        refresh ({data}) {
          this.data = data.data;
        },

        setSchedule() {
          let schedule = [];

          for (let time of this.times) {
            //  first element in a row = time
            schedule.push({css: 'time', text: this.formatAMPM(time)});

            for (let barber of this.data) {
              let cssClass = ['cell-default', 'disabled'];

              if (barber.shifts.hasOwnProperty(time)) {
                cssClass = (barber.shifts[time]) ? 'cell-free' : 'cell-busy';
              }

              schedule.push({css: [cssClass, 'cell'], text: ''});
            }
          }
          this.schedule = schedule;
        },

				updateDate(date) {
        	this.date = date;
					this.fetch();
				}
      }
    }
</script>
