class UsersController < ApplicationController
  before_action :redirect_signed_out_user, only: [:show, :edit, :update, :inbox]
  before_action :redirect_signed_in_user, only: [:new, :create]
  before_action :get_user, only: [:show, :edit, :update, :inbox]
  before_action :current_user_or_admin_only, only: [:edit, :update, :inbox]

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

  def inbox
    @parent_messages = @user.received_messages.includes(:parent_message).map do |message|
      message.parent_message_id.nil? ? message : message.parent_message
    end.uniq

    ids = "(#{@parent_messages.map(&:id).join(",")})"

    #@child_messages = Message.find_by_sql("SELECT * FROM messages m1 JOIN messages m2 ON m1.id = m2.parent_message_id WHERE m1.id IN #{ids}")
  end

  private

  def user_params
    params[:user].permit(:username, :password, :email, :avatar)
  end

  def get_user
    @user ||= User.find(params[:id])
  end

  def current_user_or_admin_only
    unless current_user == @user || current_user.admin?
      redirect_to province_url(current_user.province)
    end
  end
end
