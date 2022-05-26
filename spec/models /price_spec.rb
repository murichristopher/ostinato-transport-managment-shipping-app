require 'rails_helper'

RSpec.describe Price, type: :model do
describe "#valid?" do
    context "presence: " do
      it "false when 'cubic_meters_min' is empty" do
        price = Price.new(cubic_meters_min: '')

        price.valid?

        res = price.errors[:cubic_meters_min]

        expect(res).to include("não pode ficar em branco")
      end

      it "false when 'cubic_meters_max' is empty" do
        price = Price.new(cubic_meters_max: '')
        price.valid?

        res = price.errors[:cubic_meters_max]

        expect(res).to include("não pode ficar em branco")
      end

      it "false when 'weight_min' is empty" do
        price = Price.new(weight_min: '')
        price.valid?

        res = price.errors[:weight_min]

        expect(res).to include("não pode ficar em branco")
      end

      it "false when 'weight_max' is empty" do
        price = Price.new(weight_max: '')
        price.valid?

        res = price.errors[:weight_max]

        expect(res).to include("não pode ficar em branco")
      end

      it "false when 'value_per_km' is empty" do
        price = Price.new(value_per_km: '')
        price.valid?

        res = price.errors[:value_per_km]

        expect(res).to include("não pode ficar em branco")
      end

      it "false when 'transport_company' is nil" do
        price = Price.new(transport_company: nil)
        price.valid?

        res = price.errors[:transport_company]

        expect(res).to include("é obrigatório(a)")
      end

      it 'true when all required attributes are fullfilled' do
        transport_company = TransportCompany.create!(trading_name: "SEDEX", company_name: "SEDEX DISTRIBUICOES LTDA", domain: "sedex.com.br", registration_number: "34028316000103", full_address: "Rua dos Andares, 294")

        price = Price.create!(cubic_meters_min: 0.001, cubic_meters_max: 0.002, weight_min: 0, weight_max: 200, value_per_km: 20, transport_company:transport_company)

        price.valid?

        res = price.errors.any?

        expect(res).to(be_falsey)
        expect(price).to(be_valid)
      end
    end


end
end
