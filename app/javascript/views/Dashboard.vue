<template>
	<div class="dashboard">
		<today></today>
		<div class="block-2">
			<activities></activities>
			<booking-trend></booking-trend>
		</div>
	</div>
</template>

<script>
import Today from './components/dashboard/Today.vue';
import Activities from './components/dashboard/Activities.vue';
import BookingTrend from './components/dashboard/BookingTrend.vue';

export default {
    components: { Today, Activities, BookingTrend }
}

</script>
