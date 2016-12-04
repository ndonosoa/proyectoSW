class UsersController < ApplicationController
  def index
  end

  def create
    @user = User.new( user_name: params[:user][:user_name],
                      user_rut: params[:user][:user_rut],
                      user_email: params[:user][:user_email],
                      user_pass: params[:user][:user_pass],
                      user_tel: params[:user][:user_tel],
                      user_state: params[:user][:user_state])
    @user.save
  end

  def show
  end

  def update
  end

  def new
    @user = User.new
  end

  def delete
  end
end
