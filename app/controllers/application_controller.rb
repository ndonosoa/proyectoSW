class ApplicationController < ActionController::Base
protect_from_forgery with: :exception
before_filter :authenticate


		def authenticate
			if !session[:current_user].blank?
			else
				redirect_to login_path
			end
		end


end
