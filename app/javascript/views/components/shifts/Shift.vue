<template>
	<div :class="cssClass"></div>
</template>

<script>

	export default {

		props: ['data'],

		data() {
			return {
				cssClass: ['cell'],
				shift: this.data
			}
		},

		mounted() {
			let cellStyle = [];
			if (this.shift) {
				cellStyle = (this.shift.is_free) ? ['bg-success'] : ['bg-danger', 'disabled'];
			} else {
				cellStyle = ['bg-secondary'];
			}

			this.cssClass.push.apply(this.cssClass, cellStyle);
		}
	}

</script>
