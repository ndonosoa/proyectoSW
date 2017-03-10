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
          where state_user = 1 and type_user = 1"

   list = ActiveRecord::Base.connection.execute(sql)        
    render json: {
      user: list
    }.to_json	
end

def destroy
end

def edit
  user = User.find(params[:id])
	render json: {
		user: user
	}.to_json
end

def updatemail
  @user = User.find(params[:id])
  @user.email_user = params[:objemail][:email_user]
  if @user.save
  else
    render :json => { :errors => @user.errors }, :status => 422
  end
end

def update
  if @user.update(name_user: params[:user][:name_user],
                      rut_user: params[:user][:rut_user],
                      email_user: params[:user][:email_user])
  else
    render :json => { :errors => @user.errors }, :status => 422
  end  
end

def softdeleteuser
  @user.state_user = 0
  if @user.save
  else
    render :json => { :errors => @user.errors }, :status => 422
  end
end


def updateuser
    @user.password_user = params[:updateuser][:password_user]
    @user.email_user = params[:updateuser][:email_user]
    if @user.save
    else
      render :json => { :errors => @user.errors }, :status => 422
    end
end

def create


  @reactivar = User.find_by(rut_user: params[:user][:rut_user])
  if @reactivar && @reactivar.state_user == 0
    @reactivar.state_user = 1
    @reactivar.password_user = @reactivar.rut_user[0,4]
    if @reactivar.save
    else
      render :json => { :errors => @reactivar.errors }, :status => 422
    end
  else
    @user = User.new(name_user: params[:user][:name_user],
                      rut_user: params[:user][:rut_user],
                      email_user: params[:user][:email_user])
    @user.password_user = @user.rut_user[0,4]
    @user.state_user = 1
    @user.type_user = 1
    if @user.save
    else
      render :json => { :errors => @user.errors }, :status => 422
    end
  end

end

    def set_user
      @user = User.find(params[:id])
    end
end
