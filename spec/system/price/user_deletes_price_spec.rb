require 'rails_helper'

describe 'Usuário deleta um preço' do
  it 'e não afeta os demais' do
    transport_company = TransportCompany.create!(trading_name: "SEDEX", company_name: "SEDEX DISTRIBUICOES LTDA", domain: "sedex.com.br", registration_number: "34028316000103", full_address: "Rua dos Andares, 294")

    Price.create!(cubic_meters_min: 0.001, cubic_meters_max: 0.900, weight_min:0.1, weight_max:29.99, value_per_km:3.25, transport_company:transport_company)

    Price.create!(cubic_meters_min: 0.001, cubic_meters_max: 2.900, weight_min:30, weight_max:100, value_per_km:7.25, transport_company:transport_company)

    user = User.create!(email:"joao@sedex.com.br", password:"123456")
    login_as(user, scope: :user)

    visit(root_path)

    click_on("Ver preços")

    within(".t-line1") do
      click_on("Deletar")
    end

    expect(page).to have_content("Preço deletado com sucesso!")

    within("table") do
      expect(page).not_to have_content("0.001m³ á 2.9m³ 30kg á 100kg R$7.25")
      expect(page).to have_content("0.001m³ á 0.9m³ 0.1kg á 29.99kg R$3.25")
    end
  end
end
