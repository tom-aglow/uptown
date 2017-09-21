<template>
    <input type="text" id="dashboard-date">
</template>

<script>
    export default {
    	props: ['date'],

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
          autoclose: true
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
