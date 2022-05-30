require 'rails_helper'

RSpec.describe WorkOrderRoute, type: :model do
 describe '#valid?' do
    context "presence" do
      it "false when 'title' is empty" do
        transport_company = TransportCompany.create!(trading_name: "SEDEX", company_name: "SEDEX DISTRIBUICOES LTDA", domain: "sedex.com.br", registration_number: "34028316000103", full_address: "Rua dos Andares, 294")
        carrier_vehicle = CarrierVehicle.create!(license_plate: "ABC2334", brand: "Sedan", model: "Master", year: "2005", maximum_load_capacity: 200, transport_company:transport_company)

        Price.create!(cubic_meters_min: 0.001, cubic_meters_max: 0.900, weight_min:0.1, weight_max:29.99, value_per_km:3.25, transport_company:transport_company)
        DeliveryTime.create!(km_min:1, km_max: 49, time: 2, transport_company: transport_company)
        carrier_vehicle = CarrierVehicle.create!(license_plate: "ABC2334", brand: "Fiat", model: "Toro", year: "2005", maximum_load_capacity: 200, transport_company:transport_company)

        work_order = WorkOrder.create!(sender_address: "Rua dos Andares, 121", receiver_address: "Rua Dos Felícios, 91", receiver_name: "Márcio Andrade", receiver_cpf: "43330123456", cubic_size: 0.3, total_weight: 12, total_distance: 3, transport_company: transport_company, carrier_vehicle: carrier_vehicle)

        work_order_route = WorkOrderRoute.new(date: Date.yesterday, title:"", work_order: work_order)

        work_order_route.valid?

        res = work_order_route.errors[:title]

        expect(res).to include("não pode ficar em branco")
      end

      it "false when 'last_location' is empty" do
         transport_company = TransportCompany.create!(trading_name: "SEDEX", company_name: "SEDEX DISTRIBUICOES LTDA", domain: "sedex.com.br", registration_number: "34028316000103", full_address: "Rua dos Andares, 294")
        carrier_vehicle = CarrierVehicle.create!(license_plate: "ABC2334", brand: "Sedan", model: "Master", year: "2005", maximum_load_capacity: 200, transport_company:transport_company)

        Price.create!(cubic_meters_min: 0.001, cubic_meters_max: 0.900, weight_min:0.1, weight_max:29.99, value_per_km:3.25, transport_company:transport_company)
        DeliveryTime.create!(km_min:1, km_max: 49, time: 2, transport_company: transport_company)
        carrier_vehicle = CarrierVehicle.create!(license_plate: "ABC2334", brand: "Fiat", model: "Toro", year: "2005", maximum_load_capacity: 200, transport_company:transport_company)

        work_order = WorkOrder.create!(sender_address: "Rua dos Andares, 121", receiver_address: "Rua Dos Felícios, 91", receiver_name: "Márcio Andrade", receiver_cpf: "43330123456", cubic_size: 0.3, total_weight: 12, total_distance: 3, transport_company: transport_company, carrier_vehicle: carrier_vehicle)

        work_order_route = WorkOrderRoute.new(date: Date.yesterday, last_location:"", work_order: work_order)

        work_order_route.valid?

        res = work_order_route.errors[:title]

        expect(res).to include("não pode ficar em branco")
      end

      it "false when 'title' is above the required length" do
         transport_company = TransportCompany.create!(trading_name: "SEDEX", company_name: "SEDEX DISTRIBUICOES LTDA", domain: "sedex.com.br", registration_number: "34028316000103", full_address: "Rua dos Andares, 294")
        carrier_vehicle = CarrierVehicle.create!(license_plate: "ABC2334", brand: "Sedan", model: "Master", year: "2005", maximum_load_capacity: 200, transport_company:transport_company)

        Price.create!(cubic_meters_min: 0.001, cubic_meters_max: 0.900, weight_min:0.1, weight_max:29.99, value_per_km:3.25, transport_company:transport_company)
        DeliveryTime.create!(km_min:1, km_max: 49, time: 2, transport_company: transport_company)
        carrier_vehicle = CarrierVehicle.create!(license_plate: "ABC2334", brand: "Fiat", model: "Toro", year: "2005", maximum_load_capacity: 200, transport_company:transport_company)

        work_order = WorkOrder.create!(sender_address: "Rua dos Andares, 121", receiver_address: "Rua Dos Felícios, 91", receiver_name: "Márcio Andrade", receiver_cpf: "43330123456", cubic_size: 0.3, total_weight: 12, total_distance: 3, transport_company: transport_company, carrier_vehicle: carrier_vehicle)

        work_order_route = WorkOrderRoute.new(date: Date.yesterday, title:"ASDJSADJSANDJSANDSANDSANDJSANDJSANDJSANDJSANDJANDJSANDJASNJANSDJSANDJANDJNAJDN", work_order: work_order)

        work_order_route.valid?

        res = work_order_route.errors[:title]

        expect(res).to include("é muito longo (máximo: 50 caracteres)")
      end


    end



  end
end
