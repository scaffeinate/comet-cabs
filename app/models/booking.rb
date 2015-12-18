class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :driver
  belongs_to :cab_type

  enum status: {
    pending: 0,
    started: 1,
    confirmed: 2,
    finsihed: 3
  }
end
