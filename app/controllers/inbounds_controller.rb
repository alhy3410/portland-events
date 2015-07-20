class InboundsController < ApplicationController
  protect_from_forgery except: :create
  def create
    @currentTime = Time.new
    @events = Event.all

    @messagebody = params["Body"]
    @messagereturnbody = []
    if @messagebody == "event"
      @events.each do |event|
        if event.eventdate.strftime("%Y-%m-%d") == @currentTime.strftime("%Y-%m-%d")
          @messagereturnbody.push(event.eventname)
        end
      end
    else
      @messagereturnbody = "What do you want?"
    end

    @messagereturnbody.join(",")
    @numbertoreply = params["From"]
    @from_number = ENV['FROM_PHONE_NUMBER']
    msg = Message.new(to: @numbertoreply, from: @from_number.to_i, body: @messagereturnbody, contact_id: 0)
    binding.pry
    msg.save
  end
end
