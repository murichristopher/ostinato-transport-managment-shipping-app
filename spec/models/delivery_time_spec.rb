require 'rails_helper'

RSpec.describe DeliveryTime, type: :time do
 describe "#valid?" do
    context "presence: " do
      it "false when 'km_min' is empty" do
        delivery_time = DeliveryTime.new(km_min: '')

        delivery_time.valid?

        res = delivery_time.errors[:km_min]

        expect(res).to include("não pode ficar em branco")
      end

      it "false when 'km_max' is empty" do
        delivery_time = DeliveryTime.new(km_max: '')
        delivery_time.valid?

        res = delivery_time.errors[:km_max]

        expect(res).to include("não pode ficar em branco")
      end

      it "false when 'time' is empty" do
        delivery_time = DeliveryTime.new(time: '')
        delivery_time.valid?

        res = delivery_time.errors[:time]

        expect(res).to include("não pode ficar em branco")
      end

      it "false when 'transport_company' is nil" do
        delivery_time = DeliveryTime.new(transport_company: nil)
        delivery_time.valid?

        res = delivery_time.errors[:transport_company]

        expect(res).to include("é obrigatório(a)")
      end

      it 'true when all required attributes are fullfilled' do
        transport_company = TransportCompany.create!(trading_name: "SEDEX", company_name: "SEDEX DISTRIBUICOES LTDA", domain: "sedex.com.br", registration_number: "34028316000103", full_address: "Rua dos Andares, 294")

        delivery_time = DeliveryTime.create!(km_min: 1, km_max: 7, time: 2, transport_company:transport_company)

        delivery_time.valid?

        res = delivery_time.errors.any?

        expect(res).to(be_falsey)
        expect(delivery_time).to(be_valid)
      end
    end
  end

  context "custom validations" do
    it "false when km_min is greater than km_max" do
      delivery_time = DeliveryTime.new(km_min: 8, km_max: 4)
      delivery_time.valid?

      res = delivery_time.errors[:km_max]
      expect(res).to include("deve ser maior que o Quilômetro Mínimo")
    end
  end
end

