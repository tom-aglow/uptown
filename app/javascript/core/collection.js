export default {
	data () {
		return {
			items: [],
			page: '/'
		};
	},

	created() {
		this.fetch();
	},

	methods: {

		fetch() {
			axios.get(this.page).then(this.refresh);
		},

		refresh ({data}) {
			this.items = data;
		},
	}
}
