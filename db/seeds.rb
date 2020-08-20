Warehouse.create!(name: "Khu sửa chữa", area: "3 km2", amount: 100)
Warehouse.create!(name: "Khu ready", area: "5 km2", amount: 100)

User.create!(name: "Radar's admin", email: "admin1@airport.org", password: "123456", password_confirmation: "123456",
  admin: true, activated: true, activated_at: Time.zone.now, warehouse_id: 1)

User.create!(name: "Ready admin", email: "admin2@airport.org", password: "123456", password_confirmation: "123456",
  admin: true, activated: true, activated_at: Time.zone.now, warehouse_id: 2)

warehouses = Warehouse.order(:created_at).take(2)
2.times do |n|
  name = "Manager Example"
  email = "manager#{n+1}@airport.org"
  password = "123456"
  warehouses.each { |warehouses| warehouses.users.create!(name: name, email: email, password: "123456", password_confirmation: "123456",
    manager: true, activated: true, activated_at: Time.zone.now) }
end

10.times do |n|
  name = Faker::Name.name
  email = "employee#{n+1}@airport.org"
  password = "123456"
  warehouses.each { |warehouses| warehouses.users.create!(name: name, email: email, password: "123456", password_confirmation: "123456",
    activated: true, activated_at: Time.zone.now) }
end

50.times do |n|
  warehouses.each { |warehouses| warehouses.locations.create!(filled: false) }
end

locations = Location.all
60.times do |n|

  plane = Plane.create!(
    code: "ABC10#{n+1}"
  )

  locations[n].update_column :filled, true
  if locations[n].warehouse_id == 1
    plane.schedules.create(
      location: locations[n],
      time: Time.zone.now,
      reason: "Need to Repair"
    )
    plane.update_column :status, "in gara"
  else
    plane.schedules.create(
      location: locations[n],
      time: Time.zone.now,
      reason: "Repaired"
    )
    plane.update_column :status, "ready"
  end
end

ACCESSORIES = %w[wheels wings screws Gears]
4.times do |n|
  Component.create!(name: ACCESSORIES.pop, amount: 1000)
end

History.create!(schedule_id: 1, component_id: 1, amount: 2, time: Time.zone.now, reason: "Bug in Gears")
component = Component.find_by id: 1
temp = component.amount - 2
component.update_column :amount, temp
