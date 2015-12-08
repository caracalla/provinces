class MessagesController < ApplicationController
  before_action :redirect_signed_out_user
  before_action :get_message, only: :show
  before_action :sender_or_admin_only, only: :show

  def create
    @message = Message.new(message_params)

    if @message.save
      flash[:success] = "Message sent!"
    else
      flash[:warning] = @message.errors.full_messages
    end

    if params[:message][:messageable_type] == "Nation"
      redirect_to nation_url(params[:message][:messageable_id])
    else
      redirect_to province_url(User.find(params[:message][:messageable_id]).province)
    end
  end

  def show
  end

  private

  def message_params
    params[:message].permit(:messageable_id, :messageable_type, :sender_id, :body)
  end

  def get_message
    @message ||= Message.find(params[:message])
  end

  def sender_or_admin_only
    unless current_user == @message.sender || current_user.admin?
      redirect_to province_url(current_user.province)
    end
  end
end
