require 'rails_helper'

describe 'Usuário visualiza tabela de preços' do

  it 'com sucesso' do
    transport_company = TransportCompany.create!(trading_name: "SEDEX", company_name: "SEDEX DISTRIBUICOES LTDA", domain: "sedex.com.br", registration_number: "34028316000103", full_address: "Rua dos Andares, 294")

    Price.create!(cubic_meters_min: 0.001, cubic_meters_max: 0.900, weight_min:0.1, weight_max:29.99, value_per_km:3.25, transport_company:transport_company)
    Price.create!(cubic_meters_min: 0.001, cubic_meters_max: 0.900, weight_min:30, weight_max:100, value_per_km:5.25, transport_company:transport_company)

    user = User.create!(email:"joao@sedex.com.br", password:"123456")
    login_as(user, scope: :user)

    visit(root_path)

    click_on("Ver preços")

    expect(page).to have_content("Metros cúbicos")
    expect(page).to have_content("Peso")
    expect(page).to have_content("Valor / KM")
    expect(page).to have_content("Ações")
    expect(page).to have_content("Editar")
    expect(page).to have_content("Deletar")

    expect(page).to have_content("0.001m³ á 0.9m³")
    expect(page).to have_content("0.1kg á 29.99kg")
    expect(page).to have_content("R$3.25")
    expect(page).to have_content("30.0kg á 100.0kg ")
    expect(page).to have_content("R$5.25")
  end

  it 'sem nenhuma cadastrada' do
    transport_company = TransportCompany.create!(trading_name: "SEDEX", company_name: "SEDEX DISTRIBUICOES LTDA", domain: "sedex.com.br", registration_number: "34028316000103", full_address: "Rua dos Andares, 294")

    user = User.create!(email:"joao@sedex.com.br", password:"123456")
    login_as(user, scope: :user)

    visit(root_path)

    click_on("Ver preços")

    expect(page).to have_content("Nenhuma tabela de preços cadastrada")
  end

end
