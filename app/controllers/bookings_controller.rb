class BookingsController < ApplicationController
  def show
    @booking = Booking.find(params[:id])
  end

  def new
    @booking = Booking.new
    @flight = Flight.select("flights.id AS id", "departure.code AS departure_code", "arrival.code AS arrival_code", "flights.start AS date")
      .joins("INNER JOIN airports AS departure ON departure.id = flights.departure_airport_id")
      .joins("INNER JOIN airports AS arrival ON arrival.id = flights.arrival_airport_id")
      .where("flights.id = ?", params[:id])
      .first

    params[:num_tickets].to_i.times { @booking.passengers.build }
  end

  def create
    @booking = Booking.create(booking_params)
    if @booking.valid?
      @booking.passengers.each do |passenger|
        PassengerMailer.with(passenger: passenger, booking: @booking).confirmation_email.deliver_later
      end
      redirect_to @booking
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def booking_params
      params.expect(booking: [ :flight_id, passengers_attributes: [ [ :name, :email ] ] ])
    end
end
