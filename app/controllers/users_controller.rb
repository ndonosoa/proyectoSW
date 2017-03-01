class UsersController < ApplicationController
  before_action :set_user, only: [:destroy, :update, :updateuser,:softdeleteuser]
  skip_before_filter :permission, only: [:show]

 def index
end

  def show
    @perfil = User.find(params[:id])
  end

 def getusers
    sql = "SELECT id, name_user, email_user, rut_user, type_user
          FROM users
          where state_user = 1"

   list = ActiveRecord::Base.connection.execute(sql)        
    render json: {
      user: list
    }.to_json	
end

def destroy
  #@user.destroy
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

def softdeleteuser
  @user.state_user = 0
  @user.save
end
def updateuser
  @user = User.update(params.require(:updateuser).permit(:email_user,:password_user))
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

    def set_user
      @user = User.find(params[:id])
    end
   def user_params
     params.require(:user).permit(:name_user, :rut_user, :email_user)
   end
end
