<!-- Static navbar -->
<nav class="navbar navbar-default navbar-static-top">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="#">Coldbox & Vue.js</a>
    </div>
    <div id="navbar" class="navbar-collapse collapse">
      <ul class="nav navbar-nav">
        <li class="active"><a href="#">Contacts</a></li>
      </ul>
    </div><!--/.nav-collapse -->
  </div>
</nav>
<div id="app" class="container">
	<div class="row">
		<div class="col-sm-4">
			<div class="panel panel-default">
			  <div class="panel-heading">
			    <strong>Add/Edit Contact</strong>
			  </div>
			  <div class="panel-body">
			    <div>
			      <div class="form-group"><input v-model="contactItem.firstName" class="form-control" value="" placeholder="First Name"></div>
			      <div class="form-group"><input v-model="contactItem.lastName" 	class="form-control" value="" placeholder="Last Name"></div>
			      <div class="form-group"><input v-model="contactItem.phone" 	class="form-control" value="" placeholder="Phone"></div>
			      <div class="form-group"><input v-model="contactItem.email" 	class="form-control" value="" placeholder="Email"></div>
			      <button class="btn btn-primary"  @click="saveContact()">Submit</button>
			    </div>
			  </div>
			</div>
		</div>
		<div class="col-sm-8">
			<table class="table">
			  <thead>
			    <tr>
			      <th>First Name</th>
			      <th>Last Name</th>
			      <th>Phone</th>
			      <th>Email</th>
			      <th></th>
			    </tr>
			  </thead>
			  <tbody>
			    <tr v-for="contact in contacts">
			      <td>{{contact.firstName}}</td>
			      <td>{{contact.lastName}}</td>
			      <td>{{contact.phone}}</td>
			      <td>{{contact.email}}</td>
			      <td><button @click="loadContact(contact)"  type="button" class="btn btn-primary">Edit</button></td>
			      <td><button @click="deleteContact(contact)"  type="button" class="btn btn-danger">X</button></td>
			    </tr>
			  </tbody>
			</table>
		</div>
	</div>
</div>

<script>

new Vue({
  // Where the app will be instantiated on the page
  el: '#app',

  // Variables that you want it to have access to or start out with
  data: {
    contactItem: {
    	id:0,
    	firstName:'',
    	lastName:'',
    	phone:'',
    	email:''
    },
    contacts: []
  },
  
  // When this module is ready run this
  ready: function() {
    this.loadContacts();
  },

  // All the methods you want the view to have access to, basically an object of functions
  methods: {
    deleteContact: function(contact) {
      var _this = this;
      this.$http.delete('/Contacts/' + contact.id, function(result) {
        _this.$set('contacts', result.data);
      });
    },

    loadContacts: function() {
      var _this = this;
      this.$http.get('/Contacts', function(result) {
        _this.$set('contacts', result.data);
      });
    },

    saveContact: function() {
      var _this = this;
      this.$http.post('Contacts',_this.contactItem, function(result) {
      	_this.contactItem = {id:0,	firstName:'',	lastName:'',	phone:'',	email:''};
        return _this.$set('contacts', result.data);
      });
    },

    loadContact: function(contact) {
      var _this = this;
      this.contactItem = contact;
    }
  }
});

</script>