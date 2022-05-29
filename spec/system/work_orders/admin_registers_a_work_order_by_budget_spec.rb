require 'rails_helper'

describe 'Admin registra uma ordem de serviço' do
  it 'a partir de um orçamento' do
    transport_company = TransportCompany.create!(trading_name: "SEDEX", company_name: "SEDEX DISTRIBUICOES LTDA", domain: "sedex.com.br", registration_number: "34028316000103", full_address: "Rua dos Andares, 294")
    second_transport_company = TransportCompany.create!(trading_name: "TEDEX", company_name: "TEDEX DISTRIBUICOES LTDA", domain: "tedex.com.br", registration_number: "12028316000103", full_address: "Rua dos Andares, 294")

    allow(SecureRandom).to receive(:alphanumeric).and_return('ANS82HJCBAS')

    admin = Admin.create!(email:"joao@sistemadefrete.com.br", password:"123456")
    login_as(admin, scope: :admin)

    Price.create!(cubic_meters_min: 0.001, cubic_meters_max: 0.900, weight_min:0.1, weight_max:29.99, value_per_km:3.25, transport_company:transport_company)
    Price.create!(cubic_meters_min: 0.001, cubic_meters_max: 2.900, weight_min:30, weight_max:100, value_per_km:7.25, transport_company:transport_company)
    DeliveryTime.create!(km_min:1, km_max: 49, time: 2, transport_company: transport_company)
    DeliveryTime.create!(km_min:50, km_max: 100, time: 7, transport_company: transport_company)

    Price.create!(cubic_meters_min: 0.001, cubic_meters_max: 0.900, weight_min:0.1, weight_max:29.99, value_per_km:23.25, transport_company:second_transport_company)
    Price.create!(cubic_meters_min: 0.001, cubic_meters_max: 2.900, weight_min:30, weight_max:100, value_per_km:11.25, transport_company:second_transport_company)
    DeliveryTime.create!(km_min:1, km_max: 49, time: 2, transport_company: second_transport_company)
    DeliveryTime.create!(km_min:50, km_max: 100, time: 6, transport_company: second_transport_company)

    visit(root_path)

    click_on("Fazer orçamento")

    fill_in "Metros Cúbicos",	with: 1
    fill_in "Peso Total",	with: 30
    fill_in "Distância Total",	with: 60
    click_on("Enviar")

    within(".b-line0") do
      click_on("Cadastrar Ordem de Serviço")
    end

    expect(page).to have_content("Preencha os dados para prosseguir:")

    fill_in "Endereço do Remetente", with: "Rua Valfenda, nº 243 - 08190490"
    fill_in "Endereço do Destinatário",	with: "Rua Élfica, nº 222, - 0138262"
    fill_in "Nome do Destinatário",	with: "Frodo Da Silva"
    fill_in "CPF do Destinatário",	with: "12947362736"

    click_on("Salvar")

    expect(page).to have_content("Ordem de Serviço cadastrada com sucesso!")

    expect(page).to have_content("pendente")
    expect(page).to have_content("#ANS82HJCBAS")
    expect(page).to have_content("Deletar")
    expect(page).to have_content("Endereço do Remetente Rua Valfenda, nº 243 - 08190490")
    expect(page).to have_content("Endereço do Destinatário Rua Élfica, nº 222, - 0138262")
    expect(page).to have_content("Nome do Destinatário Frodo Da Silva")
    expect(page).to have_content("Transportadora SEDEX")
    expect(page).to have_content("Prazo Estimado de Envio 7 dias úteis")
    expect(page).to have_content("Frete R$ 435,00")
    expect(page).to have_content("Metros Cúbicos 1.0m³")
    expect(page).to have_content("Peso Total 30.0kg")
    expect(page).to have_content("Distância Total 60km")
  end

  it 'com dados incompletos ou inválidos' do
    transport_company = TransportCompany.create!(trading_name: "SEDEX", company_name: "SEDEX DISTRIBUICOES LTDA", domain: "sedex.com.br", registration_number: "34028316000103", full_address: "Rua dos Andares, 294")
    second_transport_company = TransportCompany.create!(trading_name: "TEDEX", company_name: "TEDEX DISTRIBUICOES LTDA", domain: "tedex.com.br", registration_number: "12028316000103", full_address: "Rua dos Andares, 294")

    allow(SecureRandom).to receive(:alphanumeric).and_return('ANS82HJCBAS')

    admin = Admin.create!(email:"joao@sistemadefrete.com.br", password:"123456")
    login_as(admin, scope: :admin)

    Price.create!(cubic_meters_min: 0.001, cubic_meters_max: 0.900, weight_min:0.1, weight_max:29.99, value_per_km:3.25, transport_company:transport_company)
    Price.create!(cubic_meters_min: 0.001, cubic_meters_max: 2.900, weight_min:30, weight_max:100, value_per_km:7.25, transport_company:transport_company)
    DeliveryTime.create!(km_min:1, km_max: 49, time: 2, transport_company: transport_company)
    DeliveryTime.create!(km_min:50, km_max: 100, time: 7, transport_company: transport_company)

    Price.create!(cubic_meters_min: 0.001, cubic_meters_max: 0.900, weight_min:0.1, weight_max:29.99, value_per_km:23.25, transport_company:second_transport_company)
    Price.create!(cubic_meters_min: 0.001, cubic_meters_max: 2.900, weight_min:30, weight_max:100, value_per_km:11.25, transport_company:second_transport_company)
    DeliveryTime.create!(km_min:1, km_max: 49, time: 2, transport_company: second_transport_company)
    DeliveryTime.create!(km_min:50, km_max: 100, time: 6, transport_company: second_transport_company)

    visit(root_path)

    click_on("Fazer orçamento")

    fill_in "Metros Cúbicos",	with: 1
    fill_in "Peso Total",	with: 30
    fill_in "Distância Total",	with: 60
    click_on("Enviar")

    within(".b-line0") do
      click_on("Cadastrar Ordem de Serviço")
    end

    expect(page).to have_content("Preencha os dados para prosseguir:")

    fill_in "Endereço do Remetente", with: "Rua Valfenda, nº 243 - 08190490"
    fill_in "Endereço do Destinatário",	with: "Rua Élfica, nº 222, - 0138262"
    fill_in "Nome do Destinatário",	with: ""
    fill_in "CPF do Destinatário",	with: "12947362731232131236"

    click_on("Salvar")

    expect(page).to have_content("Nome do Destinatário não pode ficar em branco")
    expect(page).to have_content("CPF do Destinatário não possui o tamanho esperado (11 caracteres)")
  end
end
