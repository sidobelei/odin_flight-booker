class PassengerMailer < ApplicationMailer
  def confirmation_email
    booking = params[:booking]

    @passenger = params[:passenger]
    @booking_number = booking.id
    @arrival_flight = booking.flight.arrival_airport.code
    @departure_flight = booking.flight.departure_airport.code
    @date = booking.flight.start

    mail(to: @passenger.email, subject: "Flight Confirmation")
  end
end
