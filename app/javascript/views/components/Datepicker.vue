<template>
    <input type="text" :id="this.dataId" class="date-box">
</template>

<script>
    export default {
    	props: ['date', 'dataId'],

			data() {
    		return {
				}
			},

      mounted() {
				let self = this;

        $(this.$el).datepicker({
          format: 'yyyy-mm-dd',
          orientation: 'left bottom',
          todayHighlight: true,
          autoclose: true,
					weekStart: 1
        });

				$(this.$el).datepicker('update', this.date);

				$(this.$el).datepicker().on('changeDate', function () {
					let date = $(self.$el).datepicker('getDate');
					self.$emit('update-date', date);
				});
      },

			beforeDestroy() {
				$(this.$el).datepicker('hide').datepicker('destroy');
			}

    }
</script>
