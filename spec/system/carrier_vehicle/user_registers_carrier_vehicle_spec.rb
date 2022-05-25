require 'rails_helper'

describe "Usuário registra um veículo" do
  it 'com sucesso' do
    transport_company = TransportCompany.create!(trading_name: "SEDEX", company_name: "SEDEX DISTRIBUICOES LTDA", domain: "sedex.com.br", registration_number: "34028316000103", full_address: "Rua dos Andares, 294")

    user = User.create!(email:"joao@sedex.com.br", password:"123456")
    login_as(user, scope: :user)

    visit("/")

    click_on("Ver veículos")

    click_on("Cadastrar Veículo")

    fill_in("Placa do Veículo", with:"BRA2E19")
    fill_in("Marca", with:"Renault")
    fill_in("Modelo", with:"Master Minibus")
    fill_in("Ano", with:"2019")
    fill_in("Capacidade Máxima de Carga", with:"1759")

    click_on("Salvar")

    expect(page).to have_content("Veículo cadastrada com sucesso!")
    expect(page).to have_content("BRA2E19")
    expect(page).to have_content("Renault")
    expect(page).to have_content("Master Minibus")
    expect(page).to have_content("2019")
    expect(page).to have_content("1759")
    expect(page).to have_content("SEDEX")
  end

  it 'com dados inválidos ou incompletos' do
    transport_company = TransportCompany.create!(trading_name: "SEDEX", company_name: "SEDEX DISTRIBUICOES LTDA", domain: "sedex.com.br", registration_number: "34028316000103", full_address: "Rua dos Andares, 294")
    user = User.create!(email:"joao@sedex.com.br", password:"123456")
    login_as(user, scope: :user)
    visit("/")

    click_on("Ver veículos")

    click_on("Cadastrar Veículo")

    fill_in("Placa do Veículo", with:"ABDH")
    fill_in("Marca", with:"Renault")
    fill_in("Modelo", with:"")
    fill_in("Ano", with:"2019")
    fill_in("Capacidade Máxima de Carga", with:"")

    click_on("Salvar")


    expect(page).to have_field("Placa do Veículo", with:"ABDH")
    expect(page).to have_field("Marca", with:"Renault")
    expect(page).to have_field("Modelo", with:"")
    expect(page).to have_field("Ano", with:"2019")
    expect(page).to have_field("Capacidade Máxima de Carga", with:"")

    expect(page).to have_content("Placa do Veículo não é válido")
    expect(page).to have_content("Modelo não pode ficar em branco")
    expect(page).to have_content("Capacidade Máxima de Carga não pode ficar em branco")
  end
end
