require 'rails_helper'

describe 'Usuário registra uma Atualização de rota' do
  it 'com sucesso' do
    transport_company = TransportCompany.create!(trading_name: "SEDEX", company_name: "SEDEX DISTRIBUICOES LTDA", domain: "sedex.com.br", registration_number: "34028316000103", full_address: "Rua dos Andares, 294")
    carrier_vehicle = CarrierVehicle.create!(license_plate: "ABC2334", brand: "Sedan", model: "Master", year: "2005", maximum_load_capacity: 200, transport_company:transport_company)

    user = User.create!(email:"joao@sedex.com.br", password:"123456")
    login_as(user, scope: :user)

    allow(SecureRandom).to receive(:alphanumeric).and_return('ANS82HJCBAS')

    Price.create!(cubic_meters_min: 0.001, cubic_meters_max: 0.900, weight_min:0.1, weight_max:29.99, value_per_km:3.25, transport_company:transport_company)
    DeliveryTime.create!(km_min:1, km_max: 49, time: 2, transport_company: transport_company)
    WorkOrder.create!(sender_address: "Rua dos Andares, 121", receiver_address: "Rua Dos Felícios, 91", receiver_name: "Márcio Andrade", receiver_cpf: "43330123456", cubic_size: 0.3, total_weight: 12, total_distance: 3, transport_company: transport_company)


    visit(root_path)

    click_on("Ordens de serviço")

    within(".c-line0") do
      click_on("Ver detalhes")
    end

    expect(page).to have_content("pendente")

    within(".navigation-area") do
      expect(page).not_to have_content("Registrar Atualização de rota")
      click_on("Aceitar Ordem de serviço")
    end

    expect(page).to have_content("Ordem de serviço foi aceita com sucesso!")

    click_on("Registrar Atualização de rota")

    expect(page).to have_content("Deverá ser atríbuida á um veículo")
    expect(page).to have_content("Deverá possuir um título")
    expect(page).to have_content("Deverá possuir uma última localização")
    expect(page).to have_content("A data não pode ser futura")

    fill_in "Título",	with: "Á caminho de UNIDADE DE TRATAMENTO"
    select("Master", from:"carrier_vehicle[id]")
    select("Em transporte", from:"status")
    fill_in "Ultima localização",	with: "UNIDADE SEDEX - Rua dos Andradas, 22"
    fill_in "Próxima localização",	with: "UNIDADE DE TRATAMENTO - Rua do Redemoinho, 44"

    click_on("Enviar")

    expect(page).to have_content("Atualização de rota registrada com sucesso!")
    expect(page).to have_content("Á CAMINHO DE UNIDADE DE TRATAMENTO")
    expect(page).to have_content("Algumas horas atrás")
    expect(page).to have_button("Deletar")
    expect(page).to have_content("De: UNIDADE SEDEX - Rua dos Andradas, 22")
    expect(page).to have_content("Para: UNIDADE DE TRATAMENTO - Rua do Redemoinho, 44")
    expect(page).to have_content("Veículo: Master | Sedan")
  end

end
