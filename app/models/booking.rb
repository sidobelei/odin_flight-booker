class Booking < ApplicationRecord
  has_many :passengers, inverse_of: :booking, dependent: :destroy
  accepts_nested_attributes_for :passengers, allow_destroy: true
  belongs_to :flight
end
