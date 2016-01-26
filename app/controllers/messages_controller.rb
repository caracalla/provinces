class MessagesController < ApplicationController
  before_action :redirect_signed_out_user
  before_action :get_message, only: :show
  before_action :guard_user_messages, only: :show

  def create
    @message = Message.new(message_params)

    if @message.save
      flash[:success] = "Message sent!"
    else
      flash[:warning] = @message.errors.full_messages
    end

    if params[:message][:messageable_type] == "Nation"
      redirect_to messageboard_nation_url(params[:message][:messageable_id])
    else
      if params[:message][:parent_message_id].blank?
        redirect_to province_url(User.find(params[:message][:messageable_id]).province)
      else
        redirect_to message_url(params[:message][:parent_message_id])
      end
    end
  end

  def show
    @child_messages = @message.child_messages.order(:created_at)
    @new_reply = Message.new
  end

  private

  def message_params
    params[:message].permit(:messageable_id,
                            :messageable_type,
                            :sender_id,
                            :body,
                            :parent_message_id)
  end

  def get_message
    @message ||= Message.find(params[:id])
  end

  def guard_user_messages
    if @message.messageable_type == User
      if  current_user != @message.sender ||
          current_user.id != @message.messageble_id ||
          !current_user.admin?
        redirect_to province_url(current_user.province)
      end
    end
  end
end
