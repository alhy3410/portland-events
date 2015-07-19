class MessagesController < ApplicationController
  def index
    @messages = Message.order(:id)
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to messages_path
    else
      redirect_to :back
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to messages_path
  end

  private

  def message_params
    params.require(:message).permit(:to, :from, :body)
  end

end
