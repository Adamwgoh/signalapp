var React = require('react');
var $ = require('jquery');
var Functions = require('../../utils/Functions.js');

var SignOutLink = 
  React.createClass({
	  render:function(){
		  return (
			  <a href="#" onClick={this._signOut}>Signout</a>
			)
		},	
		_signOut: function(){
		  $.ajax({
			  method: "DELETE",
				url: "/users/sign_out.json",
				data: {
				  authenticity_token: Functions.getMetaContent("csrf-token")	
				}
		  }).done(function(){
			  location.reload();	
			});	
		}
	});

module.exports = SignOutLink;
