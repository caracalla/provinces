class ProvincesController < ApplicationController
  before_action :redirect_signed_out_user, except: :show
  before_action :get_province, only: [:show, :edit, :update, :destroy]
  before_action :redirect_user_with_province, only: [:new, :create]
  before_action :only_owner_or_admin, only: [:edit, :update, :destroy]

  def new
    @province = Province.new
  end

  def create
    @province = Province.new(province_params)
    @province.user_id = current_user.id

    if @province.save
      # create user notfication
      flash[:success] = "Province created!"
      redirect_to province_url(@province)
    else
      flash.now[:warning] = @province.errors.full_messages
      render :new
    end
  end

  def show
    @user = @province.user
    @message = Message.new
  end

  def edit
  end

  def update
    if @province.update(province_params)
      flash[:success] = "Province updated!"
      redirect_to province_url(@province)
    else
      flash.now[:warning] = @province.errors.full_messages
      render :edit
    end
  end

  def destroy
    @province.destroy
    flash[:success] = "Province destroyed"
    redirect_to user_url(@user)
  end

  private

  def province_params
    params[:province].permit(
      :name,
      :user_title,
      :currency_name,
      :government_type,
      :local_tax_rate,
      :description,
      :flag
    )
  end

  def get_province
    @province ||= Province.find(params[:id])
  end

  def redirect_user_with_province
    redirect_to province_url(current_user.province) if current_user.province
  end

  def only_owner_or_admin
    unless current_user.province == @province || current_user.admin?
      redirect_to province_url(current_user.province)
    end
  end
end
