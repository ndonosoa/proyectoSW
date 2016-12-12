class UsersController < ApplicationController
  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_name: params[:user][:user_name],
                          user_rut: params[:user][:user_rut],
                          user_tel: params[:user][:user_tel],
                          mail: params[:user][:email],
                          user_range: params[:user][:user_range],
                          encrypted_password: params[:user][:encrypted_password])
  end

  def show
  end

  def edit
  end

  def delete
  end
end
