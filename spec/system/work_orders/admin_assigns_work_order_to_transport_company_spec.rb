require 'rails_helper'

describe 'Admin atribui uma Ordem de serviço á uma Transportadora' do

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

    click_on("Ver transportadoras")

    click_on("SEDEX")

    click_on("Cadastrar Ordem de Serviço")

    fill_in "Endereço do Remetente",	with: "Rua dos Andares, 232"
    fill_in "Endereço do Destinatário",	with: "Rua dos Andares, 132"
    fill_in "Nome do Destinatário",	with: "Gabriel Fernandes Andrade"
    fill_in "CPF do Destinatário",	with: "12345678901"
    fill_in "Metros Cúbicos",	with: "1.2"
    fill_in "Peso Total",	with: "33"
    fill_in "Distância Total",	with: "3"

    click_on("Salvar")

    expect(page).to have_content("#ANS82HJCBAS")
    expect(page).to have_content("pendente")
    expect(page).to have_content("Endereço do Remetente Rua dos Andares, 232")
    expect(page).to have_content("Endereço do Destinatário Rua dos Andares, 132")
    expect(page).to have_content("Nome do Destinatário Gabriel Fernandes Andrade")
    expect(page).to have_content("Prazo Estimado de Envio 2 dias úteis")
    expect(page).to have_content("Frete R$ 21,75")
    expect(page).to have_content("Metros Cúbicos 1.2m³")
    expect(page).to have_content("Peso Total 33.0kg")
    expect(page).to have_content("Distância Total 3km")
  end

  it 'com dados inválidos ou incompletos' do
transport_company = TransportCompany.create!(trading_name: "SEDEX", company_name: "SEDEX DISTRIBUICOES LTDA", domain: "sedex.com.br", registration_number: "34028316000103", full_address: "Rua dos Andares, 294")

    admin = Admin.create!(email:"joao@sistemadefrete.com.br", password:"123456")

    login_as(admin, scope: :admin)

    Price.create!(cubic_meters_min: 0.001, cubic_meters_max: 0.900, weight_min:0.1, weight_max:29.99, value_per_km:3.25, transport_company:transport_company)
    Price.create!(cubic_meters_min: 0.001, cubic_meters_max: 2.900, weight_min:30, weight_max:100, value_per_km:7.25, transport_company:transport_company)
    DeliveryTime.create!(km_min:1, km_max: 49, time: 2, transport_company: transport_company)
    DeliveryTime.create!(km_min:50, km_max: 100, time: 7, transport_company: transport_company)

    visit(root_path)

    click_on("Ver transportadoras")

    click_on("SEDEX")

    click_on("Cadastrar Ordem de Serviço")

    fill_in "Endereço do Remetente",	with: ""
    fill_in "Endereço do Destinatário",	with: "Rua dos Andares, 132"
    fill_in "Nome do Destinatário",	with: "Gabriel Fernandes Andrade"
    fill_in "CPF do Destinatário",	with: "12345678901"
    fill_in "Metros Cúbicos",	with: "1123213212"
    fill_in "Peso Total",	with: "33213132132131"
    fill_in "Distância Total",	with: "-1"

    click_on("Salvar")

    expect(page).to have_content("Endereço do Remetente não pode ficar em branco")
    expect(page).to have_content("Distância Total deve ser maior que 0")
    expect(page).to have_content("Transportadora não possui preços cadastrados com esses requisitos")
  end
end

