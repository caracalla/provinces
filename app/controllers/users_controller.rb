class UsersController < ApplicationController
  before_action :redirect_signed_out_user, only: [:show, :edit, :update]
  before_action :redirect_signed_in_user, only: [:new, :create]
  before_action :get_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login(@user)
      flash[:success] = "Welcome to Provinces!"
      redirect_to new_province_url
    else
      flash.now[:warning] = @user.errors.full_messages
      render :new
    end
  end

  def show
  end

  def index
    @users = User.all
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Profile updated!"
      redirect_to province_url(@user.province)
    else
      flash[:warning] = @user.errors.full_messages
      render :edit
    end
  end

  private

  def user_params
    params[:user].permit(:username, :password, :email, :avatar)
  end

  def get_user
    @user ||= User.find(params[:id])
  end
end
