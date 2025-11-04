class Booking < ApplicationRecord
  has_many :passengers, inverse_of: :booking
  accepts_nested_attributes_for :passengers
  belongs_to :flight
end
