require 'rails_helper'

describe 'Usuário deleta uma Atualização de rota' do
  it 'sem afetar os demais' do
    transport_company = TransportCompany.create!(trading_name: "SEDEX", company_name: "SEDEX DISTRIBUICOES LTDA", domain: "sedex.com.br", registration_number: "34028316000103", full_address: "Rua dos Andares, 294")
    carrier_vehicle = CarrierVehicle.create!(license_plate: "ABC2334", brand: "Sedan", model: "Master", year: "2005", maximum_load_capacity: 200, transport_company:transport_company)

    user = User.create!(email:"joao@sedex.com.br", password:"123456")
    login_as(user, scope: :user)

    allow(SecureRandom).to receive(:alphanumeric).and_return('ANS82HJCBAS')

    Price.create!(cubic_meters_min: 0.001, cubic_meters_max: 0.900, weight_min:0.1, weight_max:29.99, value_per_km:3.25, transport_company:transport_company)
    DeliveryTime.create!(km_min:1, km_max: 49, time: 2, transport_company: transport_company)
    carrier_vehicle = CarrierVehicle.create!(license_plate: "ABC2334", brand: "Fiat", model: "Toro", year: "2005", maximum_load_capacity: 200, transport_company:transport_company)

    work_order = WorkOrder.create!(sender_address: "Rua dos Andares, 121", receiver_address: "Rua Dos Felícios, 91", receiver_name: "Márcio Andrade", receiver_cpf: "43330123456", cubic_size: 0.3, total_weight: 12, total_distance: 3, transport_company: transport_company, carrier_vehicle: CarrierVehicle.last)


    work_order_route = WorkOrderRoute.create!(date: Date.yesterday, title:"Á caminho de UNIDADE DE TRATAMENTO", last_location:"UNIDADE SEDEX - Rua dos Andradas, 22", next_location:"UNIDADE NOVA SEDEX - Rua dos Felpudos, 22", work_order: work_order)

    second_work_order_route = WorkOrderRoute.create!(date: Date.yesterday, title:"Á caminho de VILA NOVA", last_location:"UNIDADE NOVA SEDEX - Rua dos Andradas, 22", next_location:"UNIDADE VILA NOVA - Rua dos Jacupás, 222", work_order: work_order)

    work_order.aceita!



    visit(root_path)

    click_on("Ordens de serviço")

    within(".c-line0") do
      click_on("Ver detalhes")
    end

    within(".r-line0") do
      expect(page).to have_content("Á CAMINHO DE VILA NOVA")
      expect(page).to have_content("De: UNIDADE NOVA SEDEX - Rua dos Andradas, 22")
      expect(page).to have_content("Para: UNIDADE VILA NOVA - Rua dos Jacupás, 222")
      expect(page).to have_content("Veículo: Toro | Fiat")
    end
    within(".r-line1") do
      expect(page).to have_content("Á CAMINHO DE UNIDADE DE TRATAMENTO")
      expect(page).to have_content("De: UNIDADE SEDEX - Rua dos Andradas, 22")
      expect(page).to have_content("Para: UNIDADE NOVA SEDEX - Rua dos Felpudos, 22")
      click_on("Deletar")
    end


    expect(page).not_to have_content("Á CAMINHO DE UNIDADE DE TRATAMENTO")
    expect(page).not_to have_content("De: UNIDADE SEDEX - Rua dos Andradas, 22")
    expect(page).not_to have_content("Para: UNIDADE NOVA SEDEX - Rua dos Felpudos, 22")

    expect(page).to have_content("Á CAMINHO DE VILA NOVA")
    expect(page).to have_content("De: UNIDADE NOVA SEDEX - Rua dos Andradas, 22")
    expect(page).to have_content("Para: UNIDADE VILA NOVA - Rua dos Jacupás, 222")
  end
end
