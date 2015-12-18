namespace :fill do
  desc 'Fill cab types'
  task cab_types: :environment do
    CabType.delete_all
    CabType.create(name: 'Budget', base_fare: 5.0, number_of_persons: 4, per_mile_fare: 1.0)
    CabType.create(name: 'Economy', base_fare: 10.0, number_of_persons: 5, per_mile_fare: 1.5)
    CabType.create(name: 'Enterprise', base_fare: 15.0, number_of_persons: 6, per_mile_fare: 2.0)
    CabType.create(name: 'Luxury', base_fare: 15.0, number_of_persons: 4, per_mile_fare: 4.0)
  end
end
