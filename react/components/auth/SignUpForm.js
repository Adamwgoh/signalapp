var React = require('react');
var _ = require('lodash');
var Functions = require('../../utils/Functions.js');

var SignUpForm = 
  React.createClass({
		_handleInputChange: function(ev) {
			// Get a deep clone of the component's state before the input change
			var nextState = _.cloneDeep(this.state);
			
			// Update the state of the component
			nextState[ev.target.name] = ev.target.value;
			
			// Update the component's state with the new state
			this.setState(nextState);	
		},
		getInitialState: function(){
			return {
				email: '',
				password: '',
				password_confirmation: '',
				name: ''
			};	
		},	
		_handleRegistrationClick: function(e) {
			$.ajax({
				method: "POST",
				url: "/users.json",
				data: {
					users:{
						email: this.state.email,
						uid: this.state.email,
						password: this.state.password,
						password_confirmation: this.state.password_confirmation,
						name: this.state.name,
						provider: "email"	
					},
					authenticity_token: Functions.getMetaContent("csrf-token")	
				}	
			})
			.done(function(data){
				location.reload();	
			}.bind(this));			
		},
		render:function(){
			return (
				<form>
						<input type='text'
							name='name'
							placeholder='name'
							value={this.state.name}
							onChange={this._handleInputChange} />

						<input type='email'
							name='email'
							placeholder='email'
							value={this.state.email}
							onChange={this._handleInputChange} />

						<input type='password'
							name='password'
							placeholder='password'
							value={this.state.password}
							onChange={this._handleInputChange} />

						<input type='password'
							name='password_confirmation'
							placeholder='re-type password'
							value={this.state.password_confirmation}
							onChange={this.handleInputChange} />
					</div>
					<input onClick={this._handleRegistrationClick} defaultValue='sign up' />
				</form>
			)	
		}
	});

module.exports = SignUpForm;
