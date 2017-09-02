class EventAttendeesController < ApplicationController
  before_action :set_event_attendee, only: [:show, :edit, :update, :destroy]

  # GET /event_attendees
  # GET /event_attendees.json
  def index
    @event_attendees = EventAttendee.where(:paid=> [false,nil])
    @event_attendees1 = EventAttendee.where(paid: true)
    @events=Event.all
    @attendees=Attendee.all
  end

  # GET /event_attendees/1
  # GET /event_attendees/1.json
  def show
  end

  # GET /event_attendees/new
  def new
    @event_attendee = EventAttendee.new
  end

  # GET /event_attendees/1/edit
  def edit
  end
  def registration
    @event=Event.find(params[:id])
    @attendee=Attendee.new
    @event_attendee = EventAttendee.new
  end  

  # POST /event_attendees
  # POST /event_attendees.json
  def create
    @event_attendee = EventAttendee.new(event_attendee_params)
    @event=Event.where('event_date>=?', Date.today).order("event_date ASC").first
    @event_attendee.event_id=@event.id
    @event_attendee.paid=false
    respond_to do |format|
      if @event_attendee.save
        format.html { redirect_to root_path, notice: 'Event attendee was successfully created.' }
        format.json { render :show, status: :created, location: @event_attendee }
      else
        format.html { render :new }
        format.json { render json: @event_attendee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /event_attendees/1
  # PATCH/PUT /event_attendees/1.json
  def update
    respond_to do |format|
      if @event_attendee.update(event_attendee_params)
        format.html { redirect_to @event_attendee, notice: 'Event attendee was successfully updated.' }
        format.json { render :show, status: :ok, location: @event_attendee }
      else
        format.html { render :edit }
        format.json { render json: @event_attendee.errors, status: :unprocessable_entity }
      end
    end
  end
  def pay
    @event_attendee=EventAttendee.find(params[:id])
    @event_attendee.update(:paid=>true)
    redirect_to event_attendees_path
  end

  # DELETE /event_attendees/1
  # DELETE /event_attendees/1.json
  def destroy
    @event_attendee.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Event attendee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_attendee
      @event_attendee = EventAttendee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_attendee_params
      params.require(:event_attendee).permit(:attendee_id, :event_id, :paid)
    end
end
