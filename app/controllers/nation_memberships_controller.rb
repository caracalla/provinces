class NationMembershipsController < ApplicationController
  before_action :redirect_signed_out_user
  before_action :get_nation_membership, only: [:update, :approve, :destroy]
  before_action :only_nation_admin_or_owner, only: [:destroy]
  before_action :only_nation_admin, only: [:update, :approve]

  def create
    @nation_membership = NationMembership.new(
      nation_id: params[:nation_membership][:nation_id],
      province_id: current_user.province.id,
      member_title: "Member",
      state: "pending"
    )

    if @nation_membership.save
      flash[:success] = "Your request to join has been submitted!"
    else
      flash[:warning] = @nation_membership.errors.full_messages
    end

    redirect_to nation_url(@nation_membership.nation_id)
  end

  def update
    if @nation_membership.update(nation_membership_params)
      flash[:success] = "Member updated"
    else
      flash[:warning] = @nation_membership.errors.full_messages
    end

    redirect_to members_nation_url(@nation_membership.nation_id)
  end

  def destroy
    @nation_membership.destroy

    if @nation_membership.state == "pending"
      # notify member of rejection
      flash[:info] = "Membership request denied"
    else
      # notify member of removal from nation
      flash[:info] = "Membership revoked"
    end

    redirect_to members_nation_url(@nation_membership.nation)
  end

  def approve
    @nation_membership.update(state: "active")
    @nation_membership.province.pending_nation_memberships.destroy_all
    # notify member
    flash[:success] = "Membership request approved"
    redirect_to members_nation_url(@nation_membership.nation)
  end

  private

  def nation_membership_params
    params[:nation_membership].permit(:member_title, :rank)
  end

  def get_nation_membership
    @nation_membership ||= NationMembership.find(params[:id])
  end

  def only_nation_admin_or_owner
    unless current_user.nation_admin?(@nation_membership.nation) || current_user.province_id == @nation_membership.province_id
      redirect_to nation_url(@nation_membership.nation)
    end
  end

  def only_nation_admin
    unless current_user.nation_admin?(@nation_membership.nation)
      redirect_to nation_url(@nation_membership.nation)
    end
  end
end
