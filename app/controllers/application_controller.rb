class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
 	before_filter :prepare_categories
 	layout :layout_by_resource

 	private
 	
		def prepare_categories
			@categories = Category.all
		end

		def layout_by_resource
			if devise_controller?
				"home"
			else
				"application"
			end
		end
		
end
