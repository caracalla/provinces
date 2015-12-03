class NationsController < ApplicationController
  before_action :redirect_signed_out_user, except: [:show, :index]
  before_action :get_nation, only: [:show, :edit, :update, :destroy, :members]
  before_action :redirect_user_with_nation, only: [:new, :create]
  before_action :redirect_user_without_province, except: [:show, :index]
  before_action :only_nation_admin, only: [:edit, :update]

  def new
    @nation = Nation.new
  end

  def create
    @nation = Nation.new(nation_params)

    if @nation.save
      NationMembership.create(
        nation_id: @nation.id,
        province_id: current_user.province.id,
        rank: 0,
        member_title: "Founder",
        state: "active"
      )

      current_user.province.pending_nation_memberships.destroy_all

      flash[:success] = "Nation created!"
      redirect_to nation_url(@nation)
    else
      flash.now[:warning] = @nation.errors.full_messages
      render :new
    end
  end

  def show
    @provinces = @nation.provinces
  end

  def edit
  end

  def update
    if @nation.update(nation_params)
      flash[:success] = "Nation updated!"
      redirect_to nation_url(@nation)
    else
      flash.now[:warning] = @nation.errors.full_messages
      render :edit
    end
  end

  def members
    @members = NationMembership.where(nation_id: @nation.id).where(state: "active")
    @pending_members = NationMembership.where(nation_id: @nation.id).where(state: "pending")
  end

  private

  def nation_params
    params[:nation].permit(:name, :description, :flag)
  end

  def get_nation
    @nation ||= Nation.find(params[:id])
  end

  def redirect_user_with_nation
    redirect_to nation_url(current_user.nation) if current_user.nation
  end

  def only_nation_admin
    redirect_to nation_url(@nation) unless current_user.nation_admin?(@nation)
  end
end
