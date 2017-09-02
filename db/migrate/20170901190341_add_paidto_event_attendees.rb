class AddPaidtoEventAttendees < ActiveRecord::Migration
  def change
  	add_column :event_attendees, :paid, :boolean
  end
end
