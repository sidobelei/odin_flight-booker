class FlightsController < ApplicationController
  def index
    @departure_airports = Airport.joins("INNER JOIN flights ON flights.departure_airport_id = airports.id").distinct.pluck(:code)
    @arrival_airports = Airport.joins("INNER JOIN flights ON flights.arrival_airport_id = airports.id").distinct.pluck(:code)
    date_list = Flight.select(:start).order(:start).map { |date| [ date.start.to_date.to_fs(:long), date.start.to_date.to_fs(:number) ] }
    @dates = date_list.uniq
  end
end
