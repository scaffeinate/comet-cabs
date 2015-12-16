class CabType < ActiveRecord::Base
  has_many :bookings
  has_many :drivers
end
