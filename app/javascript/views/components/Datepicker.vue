<template>
    <input type="text" id="dashboard-date">
</template>

<script>
    export default {
      mounted() {
        $(this.$el).datepicker({
          format: 'yyyy-mm-dd',
          orientation: 'left bottom',
          startDate: new Date(),
          todayHighlight: true,
          autoclose: true
        });
      }
    }
</script>