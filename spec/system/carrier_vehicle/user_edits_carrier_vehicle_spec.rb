require 'rails_helper'

describe "Usuário edita um veículo" do
  it 'com sucesso' do
    transport_company = TransportCompany.create!(trading_name: "JEDEX", company_name: "JEDEX DISTRIBUICOES LTDA", domain: "jedex.com.br", registration_number: "34021316000103", full_address: "Rua dos Andares, 294")

    carrier_vehicle = CarrierVehicle.create!(license_plate:"BRA3E19", brand:"Renault", model:"Juggernaut", year:"2009", maximum_load_capacity:"1720", transport_company: transport_company)

    user = User.create!(email:"joao@jedex.com.br", password:"123456")
    login_as(user, scope: :user)

    visit(root_path)

    click_on("Ver veículos")

    within(".card") do
      click_on("Juggernaut")
    end

    click_on("Editar")

    fill_in("Placa do Veículo", with:"BRA2E19")
    fill_in("Marca", with:"Renault")
    fill_in("Modelo", with:"Master Minibus")
    fill_in("Ano", with:"2019")
    fill_in("Capacidade Máxima de Carga", with:"1759")

    click_on("Salvar")

    expect(page).to have_content("Veículo editado com sucesso!")
    expect(page).to have_content("BRA2E19")
    expect(page).to have_content("Renault")
    expect(page).to have_content("Master Minibus")
    expect(page).to have_content("2019")
    expect(page).to have_content("1759")
    expect(page).to have_content("JEDEX")
  end

  it 'com dados incompletos ou inválidos' do
    transport_company = TransportCompany.create!(trading_name: "JEDEX", company_name: "JEDEX DISTRIBUICOES LTDA", domain: "jedex.com.br", registration_number: "34021316000103", full_address: "Rua dos Andares, 294")

    carrier_vehicle = CarrierVehicle.create!(license_plate:"BRA3E19", brand:"Renault", model:"Juggernaut", year:"2009", maximum_load_capacity:"1720", transport_company: transport_company)

    user = User.create!(email:"joao@jedex.com.br", password:"123456")
    login_as(user, scope: :user)

    visit(root_path)

    click_on("Ver veículos")

    within(".card") do
      click_on("Juggernaut")
    end

    click_on("Editar")

    fill_in("Placa do Veículo", with:"BRABA2E19")
    fill_in("Marca", with:"")
    fill_in("Modelo", with:"Master Minibus")
    fill_in("Ano", with:"20192")
    fill_in("Capacidade Máxima de Carga", with:"1759")

    click_on("Salvar")

    expect(page).to have_field("Placa do Veículo", with:"BRABA2E19")
    expect(page).to have_field("Marca", with:"")
    expect(page).to have_field("Modelo", with:"Master Minibus")
    expect(page).to have_field("Ano", with:"20192")
    expect(page).to have_field("Capacidade Máxima de Carga", with:"1759")

    expect(page).to have_content("Placa do Veículo não é válido")
    expect(page).to have_content("Marca não pode ficar em branco")
    expect(page).to have_content("Ano não possui o tamanho esperado (4 caracteres)")
  end
end

