<template>
    <div class="w-today">
        <div class="table">
            <div>Time</div>
            <div v-for="barber in data" v-text="barber.first_name"></div>
        </div>
    </div>
</template>

<script>
    export default {
      data() {
        return {
          data: false
        }
      },

      created() {
        this.fetch();
      },

      methods: {
        fetch() {
          axios.get('/api/w-today').then(this.refresh);
        },

        refresh ({data}) {
          this.data = data.data;
        }
      }
    }
</script>