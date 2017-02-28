class ApplicationController < ActionController::Base
protect_from_forgery with: :exception
before_filter :authenticate
before_filter :permission


		def authenticate
			if !session[:current_user].blank?
			else
				redirect_to login_path
			end
		end

		def permission
			if session[:current_user] == 1
				redirect_back fallback_location: root_path
			end

		end

end
