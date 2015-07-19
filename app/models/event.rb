class Event < ActiveRecord::Base
  validates :eventname, :presence => true
  validates :eventperson, :presence => true
  validates :eventdate, :presence => true
  validates :eventlocation, :presence => true

end
