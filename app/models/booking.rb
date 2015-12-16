class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :driver
  belongs_to :cab_type
end
