<template>
    <div class="container">
        <h1>Services</h1>
        <table class="table table-striped table-sm services">
            <tr>
                <th class="name">Name</th>
                <th class="price">Price</th>
                <th class="actions"></th>
            </tr>
            <service v-for="service in items" :data="service"></service>
        </table>
    </div>
</template>

<script>
    import Service from './components/Service.vue'

    export default {
      components: { Service },

      data() {
        return {
          items: false
        }
      },

      created() {
        this.fetch();
      },

      methods: {
        fetch() {
          axios.get('/api/v-services').then(this.refresh).then(this.setSchedule);
        },

        refresh ({data}) {
          this.items = data.data;
        },
      }
    }
</script>