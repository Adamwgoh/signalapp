
class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  #before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :store_current_location, :unless => :devise_controller?
	after_action :store_location
	
  def store_location
    # Store last url
		return unless request.get?
    if (request.path != "/users/sign_in" &&
			  request.path != "/users/sign_up" &&
				request.path != "/users/password/new" &&
				request.path != "/users/password/edit" &&
				request.path != "/users/confirmation" &&
				request.path != "/users/sign_out" &&
				!request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath
		end
	end

	def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
	end
	
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) << :name
    devise_parameter_sanitizer.permit(:sign_up) << :provider
    devise_parameter_sanitizer.permit(:sign_up) << :uid
  end

	private

	def after_sign_out_path_for(resource)
	  request.referrer || root_path
	end

  def store_current_location
	  store_location_for(:user, request.url)
	end

	

	
end
