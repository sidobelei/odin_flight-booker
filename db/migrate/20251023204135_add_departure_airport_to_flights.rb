class AddDepartureAirportToFlights < ActiveRecord::Migration[8.0]
  def change
    add_reference :flights, :departure_airport, foreign_key: { to_table: :airports }
  end
end
