<template>
	<div :class="cssClass" @click="change"></div>
</template>

<script>

	export default {

		props: ['data'],

		data() {
			return {
				cssClass: ['cell'],
				shift: new Form(this.data)
			}
		},

		mounted() {
			this.refresh();
		},

		watch: {
			data() {
				this.shift = new Form(this.data);
				this.refresh();
			}
		},

		methods: {
			refresh() {
				//	reset cssClass array
				this.cssClass = ['cell'];

				//	add css classes according shift availability
				let cellStyle = [];
				if (this.shift.hasOwnProperty('id') && this.shift.id !== '') {
					cellStyle = (this.shift.is_free) ? ['cell-free'] : ['cell-busy', 'disabled'];
				} else {
					cellStyle = ['cell-default'];
				}

				this.cssClass.push.apply(this.cssClass, cellStyle);
			},

			change() {
				if(this.cssClass.indexOf('cell-default') > 0) {
					//	click event on available time spot -> create new shift for the barber

					this.shift.submit('post', '/api/shifts', 'shift')
						.then((response) => {
							this.create(response.data);
							flash('Success','Shift was added to barber\'s schedule');
						})
						.catch(() => flash.apply(null, this.shift.errors.toArray()));

				} else if(this.cssClass.indexOf('cell-free') > 0) {
					//	click event on barber's shift spot -> delete the shift

					this.shift.submit('delete', '/api/shifts/' + this.shift.id, 'shift')
						.then(() => {
							this.resetToDefault();
							flash('Success', 'Shift was deleted from barber\'s schedule');
						})
						.catch(() => flash.apply(null, this.shift.errors.toArray()));
				}
			},

			create(data) {
				this.shift = new Form(data);
				this.refresh();
			},

			resetToDefault() {
				//	reset shift object state to default but save date and time for it
				let date = this.shift.date;
				let time = this.shift.time;
				this.shift.reset();
				this.shift.date = date;
				this.shift.time = time;
				this.refresh();
			}
		}
	}

</script>
