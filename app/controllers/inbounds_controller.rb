class InboundsController < ApplicationController
  protect_from_forgery except: :create
  def create
    @currentTime = Time.new
    @events = Event.all
    @messagebody = params["Body"]
    @messagereturnbody = []
    eventwording = ["event", "Event", "EVENT","e","evnt","evet", "E"]

    if eventwording.include? @messagebody
      @events.each do |event|
        if event.eventdate.strftime("%Y-%m-%d") == @currentTime.strftime("%Y-%m-%d")
          @messagereturnbody.push(event.eventname)
        end
      end
      @results = @messagereturnbody.join(". ")
      render 'event.xml.erb', content_type: 'text/xml'
    else
      render 'otherresponse.xml.erb', content_type: 'text/xml'
    end


  end
end
