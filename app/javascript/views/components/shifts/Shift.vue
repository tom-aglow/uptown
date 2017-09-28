<template>
	<div :class="cssClass" @click="update"></div>
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
				if (this.shift.hasOwnProperty('id')) {
					cellStyle = (this.shift.is_free) ? ['bg-success'] : ['bg-danger', 'disabled'];
				} else {
					cellStyle = ['bg-secondary'];
				}

				this.cssClass.push.apply(this.cssClass, cellStyle);
			},

			update() {
				if(this.cssClass.indexOf('bg-secondary') > 0) {
					this.shift.submit('post', '/api/shifts', 'shift')
						.then()
						.catch(() => flash([this.shift.errors.toArray(), 'error']));
					console.log('hello');
				}
			}
		}
	}

</script>
