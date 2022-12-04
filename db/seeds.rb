# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

admin = Admin.create!(email: "admin@admin.com", password:"123456")
User.create!(email: "joao@visitante.com", password:"123456")

TransportCompany.create!(trading_name: "SEDEX", company_name: "SEDEX DISTRIBUICOES LTDA", domain: "sedex.com.br", registration_number: "34028316000103", full_address: "Rua dos Andares, 294")

TransportCompany.create!(trading_name: "VEDEX", company_name: "VEDEX DISTRIBUICOES LTDA", domain: "vedex.com.br", registration_number: "34023346100103", full_address: "Rua dos Garibaldis, 294")

TransportCompany.create!(trading_name: "DIRECTLY MAIL", company_name: "DIRECTLY MAIL DISTRIBUICOES LTDA", domain: "dm.com.br", registration_number: "34052371020103", full_address: "Rua dos Felpudos, 294")

TransportCompany.create!(trading_name: "BRASIL MAIL", company_name: "BRASIL MAIL DISTRIBUICOES LTDA", domain: "brasilmail.com.br", registration_number: "34028316111103", full_address: "Rua dos Andares, 294")

User.create!(email: "rodrigo@sedex.com.br", password:"123456")
User.create!(email: "marcio@dm.com.br", password:"123456")
User.create!(email: "fernande@brasilmail.com.br", password:"123456")
User.create!(email: "marcinhaa22@vedex.com.br", password:"123456")

Price.create!(cubic_meters_min: 0.001, cubic_meters_max: 0.200, weight_min: 0, weight_max: 200, value_per_km: 2, transport_company:TransportCompany.first)
Price.create!(cubic_meters_min: 0.201, cubic_meters_max: 0.500, weight_min: 0, weight_max: 200, value_per_km: 6, transport_company:TransportCompany.first)
Price.create!(cubic_meters_min: 0.501, cubic_meters_max: 0.602, weight_min: 0, weight_max: 200, value_per_km: 7, transport_company:TransportCompany.first)
Price.create!(cubic_meters_min: 0.603, cubic_meters_max: 0.902, weight_min: 0, weight_max: 200, value_per_km: 44, transport_company:TransportCompany.first)

Price.create!(cubic_meters_min: 0.001, cubic_meters_max: 0.200, weight_min: 0, weight_max: 200, value_per_km: 1, transport_company:TransportCompany.second)
Price.create!(cubic_meters_min: 0.201, cubic_meters_max: 0.500, weight_min: 0, weight_max: 200, value_per_km: 4, transport_company:TransportCompany.second)
Price.create!(cubic_meters_min: 0.501, cubic_meters_max: 0.602, weight_min: 0, weight_max: 200, value_per_km: 5, transport_company:TransportCompany.second)
Price.create!(cubic_meters_min: 0.603, cubic_meters_max: 0.902, weight_min: 0, weight_max: 200, value_per_km: 24, transport_company:TransportCompany.second)

Price.create!(cubic_meters_min: 0.001, cubic_meters_max: 0.200, weight_min: 0, weight_max: 200, value_per_km: 3, transport_company:TransportCompany.third)
Price.create!(cubic_meters_min: 0.201, cubic_meters_max: 0.500, weight_min: 0, weight_max: 200, value_per_km: 6, transport_company:TransportCompany.third)
Price.create!(cubic_meters_min: 0.501, cubic_meters_max: 0.602, weight_min: 0, weight_max: 200, value_per_km: 8, transport_company:TransportCompany.third)
Price.create!(cubic_meters_min: 0.603, cubic_meters_max: 0.902, weight_min: 0, weight_max: 200, value_per_km: 50, transport_company:TransportCompany.third)

DeliveryTime.create!(km_min: 1, km_max: 7, time: 2, transport_company:TransportCompany.first)
DeliveryTime.create!(km_min: 7, km_max: 10, time: 4, transport_company:TransportCompany.first)
DeliveryTime.create!(km_min: 10, km_max: 30, time: 6, transport_company:TransportCompany.first)

DeliveryTime.create!(km_min: 1, km_max: 20, time: 6, transport_company:TransportCompany.second)
DeliveryTime.create!(km_min: 20, km_max: 50, time: 10, transport_company:TransportCompany.second)
DeliveryTime.create!(km_min: 50, km_max: 320, time:16, transport_company:TransportCompany.second)

DeliveryTime.create!(km_min: 1, km_max: 20, time: 8, transport_company:TransportCompany.third)
DeliveryTime.create!(km_min: 20, km_max: 50, time: 10, transport_company:TransportCompany.third)
DeliveryTime.create!(km_min: 50, km_max: 100, time:26, transport_company:TransportCompany.third)

CarrierVehicle.create!(license_plate: "ABC2334", brand: "Fiat", model: "Toro", year: "2005", maximum_load_capacity: 200, transport_company:TransportCompany.first)
CarrierVehicle.create!(license_plate: "ABC5334", brand: "Mercedez", model: "Juggernaut", year: "2009", maximum_load_capacity: 600, transport_company:TransportCompany.first)

CarrierVehicle.create!(license_plate: "ABC2334", brand: "Fiat", model: "Toro", year: "2005", maximum_load_capacity: 200, transport_company:TransportCompany.second)
CarrierVehicle.create!(license_plate: "ABC5334", brand: "Mercedez", model: "Juggernaut", year: "2009", maximum_load_capacity: 600, transport_company:TransportCompany.second)

CarrierVehicle.create!(license_plate: "ABC2334", brand: "Fiat", model: "Toro", year: "2005", maximum_load_capacity: 200, transport_company:TransportCompany.third)
CarrierVehicle.create!(license_plate: "ABC5334", brand: "Mercedez", model: "Juggernaut", year: "2009", maximum_load_capacity: 600, transport_company:TransportCompany.third)

WorkOrder.create!(sender_address: "Rua dos Andares, 121", receiver_address: "Rua Dos Felícios, 91", receiver_name: "Márcio Andrade", receiver_cpf: "43330123456", cubic_size: 0.3, total_weight: 12, total_distance: 3, transport_company: TransportCompany.first, carrier_vehicle: CarrierVehicle.first)

WorkOrder.create!(sender_address: "Rua dos Andares, 121", receiver_address: "Rua Dos Felícios, 91", receiver_name: "Márcio Andrade", receiver_cpf: "43330123456", cubic_size: 0.3, total_weight: 12, total_distance: 3, transport_company: TransportCompany.second, carrier_vehicle: CarrierVehicle.third)

WorkOrder.create!(sender_address: "Rua dos Andares, 121", receiver_address: "Rua Dos Felícios, 91", receiver_name: "Márcio Andrade", receiver_cpf: "43330123456", cubic_size: 0.3, total_weight: 12, total_distance: 3, transport_company: TransportCompany.third, carrier_vehicle: CarrierVehicle.fifth)

WorkOrder.create!(sender_address: "Rua dos Andares, 121", receiver_address: "Rua Dos Felícios, 91", receiver_name: "Márcio Andrade", receiver_cpf: "43330123456", cubic_size: 0.3, total_weight: 12, total_distance: 3, transport_company: TransportCompany.first, carrier_vehicle: CarrierVehicle.first)

WorkOrder.create!(sender_address: "Rua dos Andares, 121", receiver_address: "Rua Dos Felícios, 91", receiver_name: "Márcio Andrade", receiver_cpf: "43330123456", cubic_size: 0.3, total_weight: 12, total_distance: 3, transport_company: TransportCompany.second, carrier_vehicle: CarrierVehicle.third)

WorkOrder.create!(sender_address: "Rua dos Andares, 121", receiver_address: "Rua Dos Felícios, 91", receiver_name: "Márcio Andrade", receiver_cpf: "43330123456", cubic_size: 0.3, total_weight: 12, total_distance: 3, transport_company: TransportCompany.third, carrier_vehicle: CarrierVehicle.fifth)

WorkOrder.create!(sender_address: "Rua dos Andares, 121", receiver_address: "Rua Dos Felícios, 91", receiver_name: "Márcio Andrade", receiver_cpf: "43330123456", cubic_size: 0.3, total_weight: 12, total_distance: 3, transport_company: TransportCompany.first, carrier_vehicle: CarrierVehicle.first)

WorkOrder.create!(sender_address: "Rua dos Andares, 121", receiver_address: "Rua Dos Felícios, 91", receiver_name: "Márcio Andrade", receiver_cpf: "43330123456", cubic_size: 0.3, total_weight: 12, total_distance: 3, transport_company: TransportCompany.second, carrier_vehicle: CarrierVehicle.third)

WorkOrder.create!(sender_address: "Rua dos Andares, 121", receiver_address: "Rua Dos Felícios, 91", receiver_name: "Márcio Andrade", receiver_cpf: "43330123456", cubic_size: 0.3, total_weight: 12, total_distance: 3, transport_company: TransportCompany.third, carrier_vehicle: CarrierVehicle.fifth)

WorkOrder.create!(sender_address: "Rua dos Andares, 121", receiver_address: "Rua Dos Felícios, 91", receiver_name: "Márcio Andrade", receiver_cpf: "43330123456", cubic_size: 0.3, total_weight: 12, total_distance: 3, transport_company: TransportCompany.first, carrier_vehicle: CarrierVehicle.first)

WorkOrder.create!(sender_address: "Rua dos Andares, 121", receiver_address: "Rua Dos Felícios, 91", receiver_name: "Márcio Andrade", receiver_cpf: "43330123456", cubic_size: 0.3, total_weight: 12, total_distance: 3, transport_company: TransportCompany.second, carrier_vehicle: CarrierVehicle.third)

WorkOrder.create!(sender_address: "Rua dos Andares, 121", receiver_address: "Rua Dos Felícios, 91", receiver_name: "Márcio Andrade", receiver_cpf: "43330123456", cubic_size: 0.3, total_weight: 12, total_distance: 3, transport_company: TransportCompany.third, carrier_vehicle: CarrierVehicle.fifth)

WorkOrder.find(2).aceita!

WorkOrder.first.aceita!
WorkOrder.find(5).aceita!
WorkOrder.find(6).aceita!
WorkOrder.find(9).recusada!

p 'ois'
