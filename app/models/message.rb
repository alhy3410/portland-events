class Message < ActiveRecord::Base
  before_create :send_message
  validates_format_of :to,
                    :with => /\A[0-9]{10}\Z/,
                    :allow_blank => false,
                    :allow_nil => false

  private

  def send_message
    begin
      response = RestClient::Request.new(
      :method => :post,
           :url => "https://api.twilio.com/2010-04-01/Accounts/#{ENV['TWILIO_ACCOUNT_SID']}/Messages.json",
           :user => ENV['TWILIO_ACCOUNT_SID'],
           :password => ENV['TWILIO_AUTH_TOKEN'],
           :payload => { :Body => body,
                         :To => to,
                         :From => from }
      ).execute
    rescue
      false
    end
  end
end
