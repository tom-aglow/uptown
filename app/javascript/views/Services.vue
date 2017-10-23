<template>
	<div class="block-row">
		<service-list></service-list>
		<popular-services></popular-services>
	</div>
</template>

<script>
	import ServiceList from './components/services/List.vue'
	import PopularServices from './components/services/Popular.vue'

	export default {
		components: { ServiceList, PopularServices },
	}
</script>
