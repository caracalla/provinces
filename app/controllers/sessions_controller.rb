class SessionsController < ApplicationController
  before_action :redirect_signed_in_user, except: :destroy

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if @user && login(@user)
      flash[:success] = "Signed in successfully"
      if @user.province
        redirect_to province_url(@user.province)
      else
        redirect_to new_province_url
      end
    else
      flash.now[:warning] = "Couldn't find a user with those credentials"
      render :new
    end
  end

  def destroy
    logout
    flash[:success] = "Logged out successfully"
    redirect_to new_session_url
  end
end
