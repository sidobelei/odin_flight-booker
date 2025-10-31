class FlightsController < ApplicationController
  def index
    @departure_airports = Airport.joins("INNER JOIN flights ON flights.departure_airport_id = airports.id").order(:code).distinct.pluck(:code)
    @arrival_airports = Airport.joins("INNER JOIN flights ON flights.arrival_airport_id = airports.id").order(:code).distinct.pluck(:code)
    date_list = Flight.select(:start).order(:start).map { |date| [ date.start.to_date.to_fs(:long), date.start.to_date.to_fs(:number) ] }
    @dates = date_list.uniq

    unless flight_params.empty?
      @flight_list = Flight.select("departure.code AS departure_code", "arrival.code AS arrival_code", "flights.start AS date", "flights.id AS id")
        .joins("INNER JOIN airports AS departure ON departure.id = flights.departure_airport_id")
        .joins("INNER JOIN airports AS arrival ON arrival.id = flights.arrival_airport_id")
        .order(:date)
      @num_tickets = flight_params[:num_tickets]
      unless [ :departure_code ].empty? && flight_params[:arrival_code].empty? && flight_params[:date].empty?
        @flight_list = @flight_list
          .where("departure.code = ?", flight_params[:departure_code]) unless flight_params[:departure_code].empty?
        @flight_list = @flight_list
          .where("arrival.code = ?", flight_params[:arrival_code]) unless flight_params[:arrival_code].empty?
        unless flight_params[:date].empty?
          flight_date = [ flight_params[:date][0..3].to_i, flight_params[:date][4..5].to_i, flight_params[:date][6..7].to_i ]
          @flight_list = @flight_list.where("start LIKE ?", "#{Date.new(*flight_date).to_fs(:db)}%")
        end
      end
    end
  end

  private
    def flight_params
      params.permit(:departure_code, :arrival_code, :num_tickets, :date)
    end
end
