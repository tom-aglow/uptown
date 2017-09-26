<template>
    <div class="w-today">
				<h4>Day schedule</h4>
        <date-picker v-once="" @update-date="updateDate" :date="date"></date-picker>
        <div class="table">
            <div>Time</div>
            <div v-for="barber in data" v-text="barber.first_name"></div>
            <div v-for="spot in schedule" v-text="spot.text" :class="spot.css"></div>
        </div>
    </div>
</template>

<script>
    import DatePicker from '../components/Datepicker.vue'
    import TimeMixin from '../mixins/time-mixin.js'

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
              let cssClass = ['bg-secondary', 'disabled'];

              if (barber.shifts.hasOwnProperty(time)) {
                cssClass = (barber.shifts[time]) ? 'bg-success' : 'bg-danger';
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
