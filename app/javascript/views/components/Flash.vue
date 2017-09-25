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
        show: false
      }
    },

    created() {
      if (this.message) {
        this.flash(this.message, this.type);
      }

      window.events.$on('flash', ([message, type='yes']) => {
				this.flash(message, type);
			});
    },

    methods: {
      flash (message, type) {
      	switch(type) {
					case 'error':
						this.attr.lead = 'Error!';
						this.attr.className = 'alert-danger';
						break;
					case 'success':
						this.attr.lead = 'Note!';
						this.attr.className = 'alert-info';
						break;
					default:
						this.attr.lead = 'Success!';
						this.attr.className = 'alert-success';
				}

        this.body = message;
        this.show = true;

        if(type !== 'error') {
        	this.hide();
				}
      },

      hide () {
        setTimeout(() => {
          this.show = false
        }, 3000)
      }
    }
  };
</script>
