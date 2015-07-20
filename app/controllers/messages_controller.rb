class MessagesController < ApplicationController
  def index
    @messages = Message.order(:id)
  end

  def new
    @message = Message.new
  end

  def create

    @contacts = Contact.all
    from = ENV['FROM_PHONE_NUMBER']
    @contacts.each do |contact|
      msg = Message.new(to: contact.number, from: from, body: params[:body], contact_id: contact.id)
      msg.save
    end
    redirect_to messages_path

  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to messages_path
  end

  private

  def message_params
    params.require(:message).permit(:to, :from, :body, :contact_id)
  end

end
