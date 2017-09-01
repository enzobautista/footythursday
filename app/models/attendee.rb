class Attendee < ActiveRecord::Base
	has_many :event_attendees,dependent: :destroy
end
