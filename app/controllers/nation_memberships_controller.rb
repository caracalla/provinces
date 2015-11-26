class NationMembershipsController < ApplicationController
  before_action :redirect_signed_out_user
  before_action :get_nation_membership, only: [:edit, :update, :approve, :destroy]

  def create
    @nation_membership = NationMembership.new(
      nation_id: params[:nation_membership][:nation_id],
      province_id: current_user.province.id,
      member_title: "Member",
      rank: 7 # lower rank means greater authority, so start at 7 arbitrarily,
      state: "inactive"
    )

    if @nation_membership.save
      flash[:success] = "Your request to join has been submitted!"
    else
      flash[:warning] = @nation_membership.errors.full_messages
    end

    redirect_to nation_url(@nation_membership.nation_id)
  end

  def edit
  end

  def update
    if @nation_membership.update(nation_membership_params)
    end
  end

  def approve
    @nation_membership.update(state: "active")
    # notify member
    flash[:success] = "Membership request approved"
    redirect_to nation_url(@nation_membership.nation)
  end

  def destroy
    @nation_membership.destroy

    if @nation_membership.state == "inactive"
      # notify member of rejection
      flash[:info] = "Membership request denied"
    else
      # notify member of removal from nation
      flash[:info] = "Membership revoked"
    end

    redirect_to nation_url(@nation_membership.nation)
  end

  private

  def nation_membership_params
    params[:nation_membership].permit(:member_title, :rank)
  end

  def get_nation_membership
    @nation_membership ||= NationMembership.find(params[:id])
  end
end
