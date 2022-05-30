require 'rails_helper'

RSpec.describe CarrierVehicle, type: :model do
  describe "#valid?" do
    context "presence: " do
      it "false when 'license_plate' is empty" do
        carrier_vehicle = CarrierVehicle.new(license_plate: '')

        carrier_vehicle.valid?

        res = carrier_vehicle.errors[:license_plate]

        expect(res).to include("não pode ficar em branco")
      end

      it "false when 'brand' is empty" do
        carrier_vehicle = CarrierVehicle.new(brand: '')
        carrier_vehicle.valid?

        res = carrier_vehicle.errors[:brand]

        expect(res).to include("não pode ficar em branco")
      end

      it "false when 'model' is empty" do
        carrier_vehicle = CarrierVehicle.new(model: '')
        carrier_vehicle.valid?

        res = carrier_vehicle.errors[:model]

        expect(res).to include("não pode ficar em branco")
      end

      it "false when 'year' is empty" do
        carrier_vehicle = CarrierVehicle.new(year: '')
        carrier_vehicle.valid?

        res = carrier_vehicle.errors[:year]

        expect(res).to include("não pode ficar em branco")
      end

      it "false when 'maximum_load_capacity' is empty" do
        carrier_vehicle = CarrierVehicle.new(maximum_load_capacity: '')
        carrier_vehicle.valid?

        res = carrier_vehicle.errors[:maximum_load_capacity]

        expect(res).to include("não pode ficar em branco")
      end

      it "false when 'transport_company' is nil" do
        carrier_vehicle = CarrierVehicle.new(transport_company: nil)
        carrier_vehicle.valid?

        res = carrier_vehicle.errors[:transport_company]

        expect(res).to include("é obrigatório(a)")
      end

      it 'true when all required attributes are fullfilled' do
        transport_company = TransportCompany.create!(trading_name: "SEDEX", company_name: "SEDEX DISTRIBUICOES LTDA", domain: "sedex.com.br", registration_number: "34028316000103", full_address: "Rua dos Andares, 294")

        carrier_vehicle = CarrierVehicle.create!(license_plate: "ABC2334", brand: "Sedan", model: "Stylus", year: "2005", maximum_load_capacity: 200, transport_company:transport_company)

        carrier_vehicle.valid?

        res = carrier_vehicle.errors.any?

        expect(res).to(be_falsey)
        expect(carrier_vehicle).to(be_valid)
      end
    end

    context "format: " do
      it "false when 'license_plate' is in invalid format" do
        carrier_vehicle = CarrierVehicle.new(license_plate: 'ABDOP')
        carrier_vehicle.valid?

        res = carrier_vehicle.errors[:license_plate]

        expect(res).to include("não é válido")
      end

      it "false when 'year' is in invalid format" do
        carrier_vehicle = CarrierVehicle.new(maximum_load_capacity: -2)
        carrier_vehicle.valid?

        res = carrier_vehicle.errors[:maximum_load_capacity]

        expect(res).to include("deve ser maior ou igual a 0")
      end
    end

  end

  describe '#full_description' do
    it 'should return model and vehicle brand' do

      transport_company = TransportCompany.create!(trading_name: "SEDEX", company_name: "SEDEX DISTRIBUICOES LTDA", domain: "sedex.com.br", registration_number: "34028316000103", full_address: "Rua dos Andares, 294")

      carrier_vehicle = CarrierVehicle.create!(license_plate: "ABC2334", brand: "Fiat", model: "Toro", year: "2005", maximum_load_capacity: 200, transport_company:transport_company)

      res = carrier_vehicle.full_description

      expect(res).to eq("Toro | Fiat")
    end
  end
end
