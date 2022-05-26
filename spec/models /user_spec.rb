require 'rails_helper'

RSpec.describe User, type: :model do

  describe '#set_transport_company' do
    it 'should link the domain of an user email to a transport_company if there is any' do

      first_transport_company = TransportCompany.create!(trading_name: "SEDEX", company_name: "SEDEX DISTRIBUICOES LTDA", domain: "sedex.com.br", registration_number: "34028316000103", full_address: "Rua dos Andares, 294")
      second_transport_company = TransportCompany.create!(trading_name: "AMEX", company_name: "AMEX DISTRIBUICOES LTDA", domain: "amex.com.br", registration_number: "34028123000103", full_address: "Rua dos Andares, 294")

      user = User.create!(email:"gabigol@amex.com.br", password:"382843294232")

      expect(user.transport_company).to eq(second_transport_company)
      expect(user.transport_company_id).to eq(2)
      expect(second_transport_company.users.include?(user))
    end

    it 'should not link the domain of an user email to a transport_company if there is not any match' do
      first_transport_company = TransportCompany.create!(trading_name: "SEDEX", company_name: "SEDEX DISTRIBUICOES LTDA", domain: "sedex.com.br", registration_number: "34028316000103", full_address: "Rua dos Andares, 294")
      second_transport_company = TransportCompany.create!(trading_name: "AMEX", company_name: "AMEX DISTRIBUICOES LTDA", domain: "amex.com.br", registration_number: "34028123000103", full_address: "Rua dos Andares, 294")

      user = User.create!(email:"gabigol@brastemp.com.br", password:"382843294232")

      expect(user.transport_company).to be_nil
      expect(user).to be_valid
    end
  end


end
