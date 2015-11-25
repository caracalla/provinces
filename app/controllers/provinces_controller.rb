class ProvincesController < ApplicationController
  before_action :get_province_and_user, only: [:show, :edit, :update]
  before_action :redirect_user_with_province, only: [:new, :create]

  def new
    @province = Province.new
  end

  def create
    @province = Province.new(province_params)
    @province.user_id = current_user.id

    if @province.save
      flash[:success] = "Province created!"
      redirect_to province_url(@province)
    else
      # fail
      flash.now[:warning] = @province.errors.full_messages
      render :new
    end
  end

  def show
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

  private

  def province_params
    params[:province].permit(
      :name,
      :user_title,
      :currency_name,
      :government_type,
      :local_tax_rate,
      :description
    )
  end

  def get_province_and_user
    @province ||= Province.find(params[:id])
    @user ||= @province.user
  end

  def redirect_user_with_province
    redirect_to province_url(current_user.province) if current_user.province
  end
end
