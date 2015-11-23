class UsersController < ApplicationController
  before_action :redirect_signed_in_user, only: [:new, :create]
  before_action :get_user, only: :show

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login(user)
      flash[:success] = "Welcome to Provinces!"
      redirect_to user_url(@user)
    else
      flash.new[:warning] = @user.errors.full_messages
      render :new
    end
  end

  def show
  end

  def index
    @users = User.all
  end

  private

  def user_params
    params[:user].permit(:username, :password)
  end

  def get_user
    @user ||= User.find(params[:id])
  end
end
