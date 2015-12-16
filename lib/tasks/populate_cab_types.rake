namespace :fill do
  desc 'Fill cab types'
  task cab_types: :environment do
    CabType.create(name: 'Budget', base_fare: 5.0, number_of_persons: 4)
    CabType.create(name: 'Economy', base_fare: 10.0, number_of_persons: 5)
    CabType.create(name: 'Enterprise', base_fare: 15.0, number_of_persons: 6)
    CabType.create(name: 'Luxury', base_fare: 25.0, number_of_persons: 4)
  end
end
