<template>
	<div class="w-activities">
		<h4>Recent activities</h4>
		<div class="activity-row" v-for="activity in items" v-html="html(activity)"></div>
	</div>
</template>

<script>
	import collection from '../../../core/collection'

	export default {
		mixins: [collection],

		data() {
			return {
				page: '/api/clients/activities'
			}
		},

		methods: {
			html(activity) {
				return this['action_' + activity.action](activity);
			},

			action_booking(activity) {
				return `<span>${activity.name} booked a ${activity.service} on ${moment(activity.booked_at).format('MMMM Do')}</span>` +
					`<span>${moment(activity.date).fromNow()}</span>`
			},

			action_testimonial(activity) {
				return `<span>${activity.name} left a new testimonial</span>` +
					`<span>${moment(activity.date).fromNow()}</span>`
			}
		}
	}
</script>
