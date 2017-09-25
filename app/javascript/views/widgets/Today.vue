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

    export default {

      components: { DatePicker },

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
              let cssClass;

              if (barber.shifts.hasOwnProperty(time)) {
                cssClass = (barber.shifts[time]) ? 'bg-success' : 'bg-danger';
              } else {
                cssClass = ['bg-secondary', 'disabled'];
              }
              schedule.push({css: [cssClass, 'cell'], text: ''});
            }
          }
          this.schedule = schedule;
        },

				updateDate(date) {
        	this.date = date;
					this.fetch();
				},

        //  locals
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
        }
      }
    }
</script>
