<template>
	<div class="alert alert-flash" :class="attr.className" role="alert" v-show="show">
		<p v-for="msg in body">
			<strong>{{ attr.lead }}</strong> <span>{{ msg }}</span>
		</p>
	</div>
</template>

<script>
  export default {
    props: ['message', 'type'],

    data () {
      return {
        body: [],
				attr: {},
        show: false,
				timer: null
      }
    },

    created() {
      if (this.message) {
        this.flash(this.type, this.message);
      }

      window.events.$on('flash', (type, messages) => {
				this.flash(type, messages);
			});
    },

    methods: {

			flash (type, messages) {
				this['flash' + type]();
				this.body = messages;
				this.show = true;
			},

    	flashError() {
				this.attr.lead = 'Error!';
				this.attr.className = 'alert-danger';
			},

			flashSuccess() {
				this.attr.lead = 'Success!';
				this.attr.className = 'alert-success';
				this.hide();
			},

			flashNote() {
				this.attr.lead = 'Note!';
				this.attr.className = 'alert-warning';
				this.hide();
			},

      hide () {
				clearTimeout(this.timer);

        this.timer = setTimeout(() => {
          this.show = false
        }, 3000)
      },
    }
  };
</script>
