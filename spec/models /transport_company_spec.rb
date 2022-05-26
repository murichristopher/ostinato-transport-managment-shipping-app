require 'rails_helper'

RSpec.describe TransportCompany, type: :model do
  describe "#valid?" do
    context "presence" do
      it "false when 'trading_name' is empty" do
        transport_company = TransportCompany.new(trading_name: '')

        transport_company.valid?

        res = transport_company.errors[:trading_name]

        expect(res).to include("não pode ficar em branco")
      end

      it "false when 'company_name' is empty" do
        transport_company = TransportCompany.new(company_name: '')
        transport_company.valid?

        res = transport_company.errors[:company_name]

        expect(res).to include("não pode ficar em branco")
      end

      it "false when 'domain' is empty" do
        transport_company = TransportCompany.new(domain: '')
        transport_company.valid?

        res = transport_company.errors[:domain]

        expect(res).to include("não pode ficar em branco")
      end

      it "false when 'registration_number' is empty" do
        transport_company = TransportCompany.new(registration_number: '')
        transport_company.valid?

        res = transport_company.errors[:registration_number]

        expect(res).to include("não pode ficar em branco")
      end

      it "false when 'full_address' is empty" do
        transport_company = TransportCompany.new(full_address: '')
        transport_company.valid?

        res = transport_company.errors[:full_address]

        expect(res).to include("não pode ficar em branco")
      end

      it 'true when all required attributes are fullfilled' do
        transport_company = TransportCompany.create!(trading_name: "SEDEX", company_name: "SEDEX DISTRIBUICOES LTDA", domain: "sedex.com.br", registration_number: "34028316000103", full_address: "Rua dos Andares, 294")

        transport_company.valid?

        res = transport_company.errors.any?

        expect(res).to(be_falsey)
        expect(transport_company).to(be_valid)
      end
    end

    context 'uniqueness' do
      it "false when 'trading_name' is not unique" do
        first_transport_company =  TransportCompany.create!(trading_name: "SEDEX", company_name: "SEDEX DISTRIBUICOES LTDA", domain: "sedex.com.br", registration_number: "34028316000103", full_address: "Rua dos Andares, 294")

        second_transport_company = TransportCompany.new(trading_name: "SEDEX")

        second_transport_company.valid?

        res = second_transport_company.errors[:trading_name]

        expect(res).to include("já está em uso")
      end

      it "false when 'company_name' is not unique" do
        first_transport_company =  TransportCompany.create!(trading_name: "SEDEX", company_name: "SEDEX DISTRIBUICOES LTDA", domain: "sedex.com.br", registration_number: "34028316000103", full_address: "Rua dos Andares, 294")

        second_transport_company = TransportCompany.new(company_name: "SEDEX DISTRIBUICOES LTDA")

        second_transport_company.valid?

        res = second_transport_company.errors[:company_name]

        expect(res).to include("já está em uso")
      end

      it "false when 'domain' is not unique" do
        first_transport_company =  TransportCompany.create!(trading_name: "SEDEX", company_name: "SEDEX DISTRIBUICOES LTDA", domain: "sedex.com.br", registration_number: "34028316000103", full_address: "Rua dos Andares, 294")

        second_transport_company = TransportCompany.new(domain: "sedex.com.br")

        second_transport_company.valid?

        res = second_transport_company.errors[:domain]
        expect(res).to include("já está em uso")
      end

      it "false when 'registration_number' is not unique" do
        first_transport_company =  TransportCompany.create!(trading_name: "SEDEX", company_name: "SEDEX DISTRIBUICOES LTDA", domain: "sedex.com.br", registration_number: "34028316000103", full_address: "Rua dos Andares, 294")

        second_transport_company = TransportCompany.new(registration_number: "34028316000103")

        second_transport_company.valid?

        res = second_transport_company.errors[:registration_number]
        expect(res).to include("já está em uso")
      end

    end

    context "format" do
      it "false when 'registration_number' is in invalid format" do
        transport_company = TransportCompany.new(registration_number: '234329432942934324')
        transport_company.valid?

        res = transport_company.errors[:registration_number]

        expect(res).to include("não é válido")
      end

      it "false when 'domain' length is above the required" do
        transport_company = TransportCompany.new(domain: 'sedexasndjsanddnsajndsajdnsajdjasdjsandjsa.com.br')
        transport_company.valid?

        res = transport_company.errors[:domain]
        expect(res).to include("é muito longo (máximo: 30 caracteres)")
      end
    end

  end
end
