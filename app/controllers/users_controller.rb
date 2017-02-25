class UsersController < ApplicationController
  
 def index
end


 def getusers
    list = User.all       
    render json: {
      user: list
    }.to_json	
end

def destroy
  @user = User.find(params[:id])
  @user.destroy
end

def edit
  user = User.find(params[:id])
	render json: {
		user: user
	}.to_json
end

def update
  @user = User.update(user_params)
  
end


def create
    @user = User.new(user_params)
    @user.password_user = @user.rut_user[0,4]
    @user.state_user = 1
    @user.type_user = 1
   if @user.save
   else
      render :json => { :errors => @user.errors }, :status => 422
    end
end


   def user_params
     params.require(:user).permit(:name_user, :rut_user, :email_user)
   end
end
