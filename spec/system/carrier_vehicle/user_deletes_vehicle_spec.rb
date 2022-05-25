require 'rails_helper'

describe 'Usuário deleta um veículo' do

  it 'e não afeta os demais' do
    first_transport_company = TransportCompany.create!(trading_name: "JEDEX", company_name: "JEDEX DISTRIBUICOES LTDA", domain: "jedex.com.br", registration_number: "34021316000103", full_address: "Rua dos Andares, 294")

    first_carrier_vehicle = CarrierVehicle.create!(license_plate:"BRA3E19", brand:"Renault", model:"Juggernaut", year:"2009", maximum_load_capacity:"1110", transport_company: first_transport_company)

    second_carrier_vehicle = CarrierVehicle.create!(license_plate:"BRA4A19", brand:"Fiat", model:"Minibus", year:"2005", maximum_load_capacity:"1720", transport_company: first_transport_company)

    user = User.create!(email:"joao@jedex.com.br", password:"123456")
    login_as(user, scope: :user)

    visit(root_path)

    click_on("Ver veículos")

    click_on("Juggernaut")

    click_on("Deletar")

    expect(page).to have_content("Minibus")
    expect(page).to have_content("Marca: Fiat")
    expect(page).to have_content("Ano: 2005")
    expect(page).to have_content("Placa: BRA4A19")
    expect(page).to have_content("Capacidade Máxima de Carga: 1720")

    expect(page).not_to have_content("Juggernaut")
    expect(page).not_to have_content("Marca: Renault")
    expect(page).not_to have_content("Ano: 2009")
    expect(page).not_to have_content("Placa: BRA3E19")
    expect(page).not_to have_content("Capacidade Máxima de Carga: 1110")

  end

end
