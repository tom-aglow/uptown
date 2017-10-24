<template>
	<div class="dashboard">
		<today></today>
		<activities></activities>
	</div>
</template>

<script>
import Today from './components/dashboard/Today.vue';
import Activities from './components/dashboard/Activities.vue';

export default {
    components: { Today, Activities }
}

</script>
