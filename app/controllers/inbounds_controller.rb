class InboundsController < ApplicationController
  protect_from_forgery except: :create
  def create
    @currentTime = Time.new
    @events = Event.all
    @messagebody = params["Body"]
    @numbertoreply = params["From"]
    @messagereturnbody = []
    eventwording = ["event", "Event", "EVENT","e","evnt","evet", "E"]

    if /^[0-9]{2}.[0-9]{2}.[0-9]{2}$/.match(@messagebody)
      datesplit = @messagebody.split(".")
      month = datesplit[0]
      date = datesplit[1]
      year = datesplit[2]
      @events.each do |event|
        if event.eventdate.strftime("%y") == year && event.eventdate.strftime("%d") == date && event.eventdate.strftime("%m") == month
            @messagereturnbody.push(event.eventname)
        end
      end
      if @messagereturnbody.any?
        @results = @messagereturnbody.join(". ")
        render 'eventbydate.xml.erb', content_type: 'text/xml'
      else
        render 'noevent.xml.erb', content_type: 'text/xml'
      end
    elsif eventwording.include? @messagebody
      if @events.any?
        @events.each do |event|
          if event.eventdate.strftime("%Y-%m-%d") == @currentTime.strftime("%Y-%m-%d")
            @messagereturnbody.push(event.eventname)
          end
        end
        @results = @messagereturnbody.join(". ")
        render 'event.xml.erb', content_type: 'text/xml'
      else
        render 'noevent.xml.erb', content_type: 'text/xml'
      end
    else
      render 'otherresponse.xml.erb', content_type: 'text/xml'
    end


  end
end
