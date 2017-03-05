class SessionsController < ApplicationController
	skip_before_filter :authenticate, only: [:create, :new]
	skip_before_filter :permission
	def new
		
	end
	def index
	
	end
	def create
		user = User.find_by(rut_user: params[:rut_user])	
		if  user && user.password_user == params[:password_user]
			session[:current_user] = user.type_user
			session[:current_user_id] = user.id
			redirect_to root_path
		else
			
		end
	end

	def destroy
		session[:current_user] = nil
		redirect_to root_path
	end



end