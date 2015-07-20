class MessagesController < ApplicationController
  def index
    @messages = Message.order(:id)
  end

  def new
    @contacts = Contact.all
    @message = Message.new
  end

  def create
    from = ENV['FROM_PHONE_NUMBER']
    params[:contact][:selecttosend].pop
    if params[:contact][:selecttosend].any?
      params[:contact][:selecttosend].each do |id|
          msg = Message.new(to: Contact.find(id.to_i).number, from: from, body: params[:body], contact_id: id.to_i)
          msg.save
      end
    else
      @contacts = Contact.all
      @contacts.each do |contact|
        msg = Message.new(to: contact.number, from: from, body: params[:body], contact_id: contact.id)
        msg.save
      end
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
