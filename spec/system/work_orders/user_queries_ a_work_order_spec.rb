require 'rails_helper'

describe 'Usuário consulta uma ordem de serviço' do
  it 'com sucesso' do
    transport_company = TransportCompany.create!(trading_name: "SEDEX", company_name: "SEDEX DISTRIBUICOES LTDA", domain: "sedex.com.br", registration_number: "34028316000103", full_address: "Rua dos Andares, 294")
    carrier_vehicle = CarrierVehicle.create!(license_plate: "ABC2334", brand: "Sedan", model: "Master", year: "2005", maximum_load_capacity: 200, transport_company:transport_company)

    user = User.create!(email:"joao@sedex.com.br", password:"123456")
    login_as(user, scope: :user)

    allow(SecureRandom).to receive(:alphanumeric).and_return('ANS82HJCBAS')

    Price.create!(cubic_meters_min: 0.001, cubic_meters_max: 0.900, weight_min:0.1, weight_max:29.99, value_per_km:3.25, transport_company:transport_company)
    DeliveryTime.create!(km_min:1, km_max: 49, time: 2, transport_company: transport_company)
    work_order = WorkOrder.create!(sender_address: "Rua dos Andares, 121", receiver_address: "Rua Dos Felícios, 91", receiver_name: "Márcio Andrade", receiver_cpf: "43330123456", cubic_size: 0.3, total_weight: 12, total_distance: 3, transport_company: transport_company, carrier_vehicle: carrier_vehicle)

    work_order_route = WorkOrderRoute.create!(date: Date.yesterday, title:"Á caminho de UNIDADE DE TRATAMENTO", last_location:"UNIDADE SEDEX - Rua dos Andradas, 22", next_location:"UNIDADE DE TRATAMENTO - Rua do Redemoinho, 44", work_order: work_order)

    work_order.aceita!

    visit(root_path)

    click_on("Consultar Ordem de Serviço")

    fill_in "Código",	with: "#ANS82HJCBAS"

    click_on("Consultar")

   expect(page).to have_content("Sua busca foi encontrada!")

    expect(page).to have_content("#ANS82HJCBAS")
    expect(page).to have_content("Endereço do Remetente Rua dos Andares, 121")
    expect(page).to have_content("Endereço do Destinatário Rua Dos Felícios, 91")
    expect(page).to have_content("Nome do Destinatário Márcio Andrade")
    expect(page).to have_content("Transportadora SEDEX")
    expect(page).to have_content("Prazo Estimado de Envio 2 dias úteis")
    expect(page).to have_content("Frete R$ 9,75")
    expect(page).to have_content("Metros Cúbicos 0.3m³")
    expect(page).to have_content("Distância Total 3km")

    expect(page).to have_content("Á CAMINHO DE UNIDADE DE TRATAMENTO")
    expect(page).to have_content("Algumas horas atrás")
    expect(page).to have_content("De: UNIDADE SEDEX - Rua dos Andradas, 22")
    expect(page).to have_content("Para: UNIDADE DE TRATAMENTO - Rua do Redemoinho, 44")
    expect(page).to have_content("Veículo: Master | Sedan")

    expect(page).to have_button("Deletar")
    expect(page).to have_button("Registrar Atualização de rota")
  end

end
