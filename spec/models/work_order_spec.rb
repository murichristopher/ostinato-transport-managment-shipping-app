require 'rails_helper'

RSpec.describe WorkOrder, type: :model do
  describe '#valid?' do
    context "presence" do
      it "false when 'receiver_address' is empty" do
        work_order = WorkOrder.new(receiver_address: '')

        work_order.valid?

        res = work_order.errors[:receiver_address]

        expect(res).to include("não pode ficar em branco")
      end

      it "false when 'sender_address' is empty" do
        work_order = WorkOrder.new(sender_address: '')
        work_order.valid?

        res = work_order.errors[:sender_address]

        expect(res).to include("não pode ficar em branco")
      end

      it "false when 'receiver_name' is empty" do
        work_order = WorkOrder.new(receiver_name: '')
        work_order.valid?

        res = work_order.errors[:receiver_name]

        expect(res).to include("não pode ficar em branco")
      end

      it "false when 'receiver_cpf' is empty" do
        work_order = WorkOrder.new(receiver_cpf: '')
        work_order.valid?

        res = work_order.errors[:receiver_cpf]

        expect(res).to include("não pode ficar em branco")
      end

      it "false when 'cubic_size' is empty" do
        work_order = WorkOrder.new(cubic_size: '')
        work_order.valid?

        res = work_order.errors[:cubic_size]

        expect(res).to include("não pode ficar em branco")
      end

      it "false when 'total_weight' is empty" do
        work_order = WorkOrder.new(total_weight: '')
        work_order.valid?

        res = work_order.errors[:total_weight]

        expect(res).to include("não pode ficar em branco")
      end

      it "false when 'total_distance' is empty" do
        work_order = WorkOrder.new(total_distance: '')
        work_order.valid?

        res = work_order.errors[:total_distance]

        expect(res).to include("não pode ficar em branco")
      end

      it 'true when all required attributes are fullfilled' do
        transport_company = TransportCompany.create!(trading_name: "SEDEX", company_name: "SEDEX DISTRIBUICOES LTDA", domain: "sedex.com.br", registration_number: "34028316000103", full_address: "Rua dos Andares, 294")

        Price.create!(cubic_meters_min: 0.001, cubic_meters_max: 2.900, weight_min:1, weight_max:100, value_per_km:7.25, transport_company:transport_company)

        DeliveryTime.create!(km_min:1, km_max: 10, time: 7, transport_company: transport_company)

        work_order = WorkOrder.create!(sender_address: "Rua dos Andares, 121", receiver_address: "Rua Dos Felícios, 91", receiver_name: "Márcio Andrade", receiver_cpf: "43330123456", cubic_size: 0.3, total_weight: 12, total_distance: 3, transport_company: transport_company)

        work_order.valid?

        res = work_order.errors.any?

        expect(res).to(be_falsey)
        expect(work_order).to(be_valid)
      end
    end

    context 'uniqueness' do
      it "false when 'unique_code' is not unique" do
        transport_company = TransportCompany.create!(trading_name: "SEDEX", company_name: "SEDEX DISTRIBUICOES LTDA", domain: "sedex.com.br", registration_number: "34028316000103", full_address: "Rua dos Andares, 294")

        Price.create!(cubic_meters_min: 0.001, cubic_meters_max: 2.900, weight_min:1, weight_max:100, value_per_km:7.25, transport_company:transport_company)

        DeliveryTime.create!(km_min:1, km_max: 10, time: 7, transport_company: transport_company)

        work_order = WorkOrder.create!(sender_address: "Rua dos Andares, 121", receiver_address: "Rua Dos Felícios, 91", receiver_name: "Márcio Andrade", receiver_cpf: "43330123456", cubic_size: 0.3, total_weight: 12, total_distance: 3, transport_company: transport_company)

        work_order_2 = WorkOrder.create!(sender_address: "Rua dos Andares, 121", receiver_address: "Rua Dos Felícios, 91", receiver_name: "Márcio Andrade", receiver_cpf: "43330123456", cubic_size: 0.3, total_weight: 12, total_distance: 3, transport_company: transport_company)

        work_order_2.valid?

        res = work_order_2.unique_code == work_order.unique_code

        expect(res).to be_falsey
      end
    end

    context "format" do
      it "false when 'cubic_size' is less than 0" do
        work_order = WorkOrder.new(cubic_size: -2)
        work_order.valid?

        res = work_order.errors[:cubic_size]

        expect(res).to include("deve ser maior que 0")
      end
      it "false when 'total_distance' is less than 0" do
        work_order = WorkOrder.new(total_distance: -2)
        work_order.valid?

        res = work_order.errors[:total_distance]

        expect(res).to include("deve ser maior que 0")
      end
      it "false when 'total_weight' is less than 0" do
        work_order = WorkOrder.new(total_weight: -2)
        work_order.valid?

        res = work_order.errors[:total_weight]

        expect(res).to include("deve ser maior que 0")
      end

      it "false when 'cpf' length is above the required" do
        work_order = WorkOrder.new(receiver_cpf: '232112')
        work_order.valid?

        res = work_order.errors[:receiver_cpf]
        expect(res).to include("não possui o tamanho esperado (11 caracteres)")
      end

      it "false when 'cpf' length is below the required" do
        work_order = WorkOrder.new(receiver_cpf: '138213821738217382138782173878213782173')
        work_order.valid?

        res = work_order.errors[:receiver_cpf]
        expect(res).to include("não possui o tamanho esperado (11 caracteres)")
      end
    end

    context "custom validations" do
      it 'false when TransportCompany prices does not apply to requirements' do
        transport_company = TransportCompany.create!(trading_name: "SEDEX", company_name: "SEDEX DISTRIBUICOES LTDA", domain: "sedex.com.br", registration_number: "34028316000103", full_address: "Rua dos Andares, 294")

        Price.create!(cubic_meters_min: 0.001, cubic_meters_max: 2.900, weight_min:1, weight_max:100, value_per_km:7.25, transport_company:transport_company)

        DeliveryTime.create!(km_min:1, km_max: 10, time: 7, transport_company: transport_company)

        work_order = WorkOrder.create(sender_address: "Rua dos Andares, 121", receiver_address: "Rua Dos Felícios, 91", receiver_name: "Márcio Andrade", receiver_cpf: "43330123456", cubic_size: 12313, total_weight: 12, total_distance: 3121, transport_company: transport_company)

        res = work_order.errors[:transport_company]

        expect(res).to include("não possui preços cadastrados com esses requisitos")
      end
    end

  end
end
