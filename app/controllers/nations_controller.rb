class NationsController < ApplicationController
  before_action :redirect_signed_out_user, except: [:show, :index]
  before_action :get_nation, only: [:show, :edit, :update, :destroy]
  before_action :redirect_user_with_nation, only: [:new, :create]

  def new
    @nation = Nation.new
  end

  def create
    @nation = Nation.new(nation_params)

    if @nation.save
      flash[:success] = "Nation created!"
      redirect_to nation_url(@nation)
    else
      flash.now[:warning] = @nation.errors.full_messages
      render :new
    end
  end

  def show
  end

  private

  def nation_params
    params[:nation].permit(:name, :description)
  end

  def get_nation
    @nation ||= Nation.find(params[:id])
  end

  def redirect_user_with_nation
    redirect_to nation_url(current_user.nation) if current_user.nation
  end

  def only_leader_or_admin
  end
end
