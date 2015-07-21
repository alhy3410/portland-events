class InboundsController < ApplicationController
  protect_from_forgery except: :create
  def create
    @currentTime = Time.new
    @events = Event.all
    @messagebody = params["Body"]

    @messagereturnbody = []
    if @messagebody.downcase == "event"
      @events.each do |event|
        if event.eventdate.strftime("%Y-%m-%d") == @currentTime.strftime("%Y-%m-%d")
          @messagereturnbody.push(event.eventname)
        end
      end
    else
      @messagereturnbody = "Nothing to see here."
    end
    @results = @messagereturnbody.join(",")
    render 'create.xml.erb', content_type: 'text/xml'
  end
end
