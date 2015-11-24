class ProvincesController < ApplicationController
  before_action :get_province, only: [:show, :edit, :update]

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
      flash.now[:warning] = "Unable to create province"
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
      flash.now[:warning] = "Unable to update province"
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

  def get_province
    @province ||= Province.find(params[:id])
  end
end
