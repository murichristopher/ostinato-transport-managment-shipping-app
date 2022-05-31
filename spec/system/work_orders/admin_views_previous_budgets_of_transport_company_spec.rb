require 'rails_helper'

describe 'Admin visualiza orçamentos prévios de uma Transportadora' do
  it 'com sucesso' do
    transport_company = TransportCompany.create!(trading_name: "SEDEX", company_name: "SEDEX DISTRIBUICOES LTDA", domain: "sedex.com.br", registration_number: "34028316000103", full_address: "Rua dos Andares, 294")

    admin = Admin.create!(email:"joao@sistemadefrete.com.br", password:"123456")
    login_as(admin, scope: :admin)

    allow(SecureRandom).to receive(:alphanumeric).and_return('ANS82HJCBAS')

    Price.create!(cubic_meters_min: 0.001, cubic_meters_max: 0.900, weight_min:0.1, weight_max:29.99, value_per_km:3.25, transport_company:transport_company)
    Price.create!(cubic_meters_min: 0.001, cubic_meters_max: 2.900, weight_min:30, weight_max:100, value_per_km:7.25, transport_company:transport_company)
    DeliveryTime.create!(km_min:1, km_max: 49, time: 2, transport_company: transport_company)
    DeliveryTime.create!(km_min:50, km_max: 100, time: 7, transport_company: transport_company)

    visit(root_path)

    within(".navigation") do
      click_on("Fazer orçamento")
    end

    fill_in "Metros Cúbicos",	with: 0.1
    fill_in "Peso",	with: 0.1
    fill_in "Distância Total",	with: 11
    click_on("Enviar")

    expect(page).to have_content("SEDEX")
    expect(page).to have_content("Valor: R$ 35,75")
    expect(page).to have_content("Tempo Estimado de Envio: 2 dias úteis")

    click_on("Home")

    click_on("Ver transportadoras")

    click_on("SEDEX")

    expect(page).to have_content("Últimos orçamentos")
    expect(page).to have_content("R$ 35,75")
    expect(page).to have_content("Peso: 0.1kg")
    expect(page).to have_content("M. Cúbicos: 0.1m³")
    expect(page).to have_content("Distância: 11km")
    expect(page).to have_content("Prazo: 2 dias úteis")

  end
end
