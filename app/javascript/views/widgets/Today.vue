<template>
    <div class="w-today">
        <div class="table">
            <div>Time</div>
            <div v-for="barber in data" v-text="barber.first_name"></div>
            <div v-for="spot in schedule" v-text="spot"></div>
        </div>
    </div>
</template>

<script>
    export default {
      data() {
        return {
          data: false,
          times: this.setTimes(),
          schedule: false
        }
      },

      created() {
        this.fetch();
      },

      methods: {
        fetch() {
          axios.get('/api/w-today').then(this.refresh).then(this.setSchedule);
        },

        refresh ({data}) {
          this.data = data.data;
        },
        
        setSchedule() {
          let schedule = [];
          for (let time of this.times) {
            schedule.push(this.formatAMPM(time));
            for (let barber of this.data) {
              schedule.push(barber.id);
            }
          }
          this.schedule = schedule;
        },

        //  private
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