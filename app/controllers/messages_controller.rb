class MessagesController < ApplicationController
  before_filter :set_message, :only => [:edit, :update, :destroy, :show]

  def index
  end

  def create
    set_session_user
    @message = @user.message_sends.build(message_params)
    if @message.save
      redirect_to @message, notice: t('message.created')
    else
      render :new
    end
  end

  def show
  end

  def new
    @message = Message.new
  end

  def edit
  end

  def update
    if  @message.update_attributes(message_params)
      redirect_to @message, notice: t('message.updated')
    else
      render :edit
    end
  end

  def destroy
    @message.destroy
    redirect_to :action => "index"
  end

  def set_message
    set_session_user
    @message = Message.find(params[:id])
    if !@message.can_managed_by(@user)
      redirect_to action: :index
    end
  end

  def message_params
    params.require(:message).permit(:title, :body, :message_receiver_id)
  end
end
