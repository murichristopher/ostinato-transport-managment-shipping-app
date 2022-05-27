require 'rails_helper'

describe 'Usuário registra prazos de envio' do
  it 'com sucesso' do
    transport_company = TransportCompany.create!(trading_name: "JEDEX", company_name: "JEDEX DISTRIBUICOES LTDA", domain: "jedex.com.br", registration_number: "34021316000103", full_address: "Rua dos Andares, 294")

    user = User.create!(email: "joao@jedex.com.br", password:"123456")
    login_as(user, scope: :user)

    visit(root_path)

    click_on("Prazos de envio")

    click_on("Cadastrar novo prazo")

    fill_in "Quilômetros Mínimo",	with: "0.1"
    fill_in "Quilômetros Máximo",	with: "49"
    fill_in "Prazo", with: "2"

    click_on("Salvar")

    within("table") do
      expect(page).to have_content("0km á 49km 2 dias úteis")
    end
  end
  it 'com dados incompletos ou inválidos' do
    transport_company = TransportCompany.create!(trading_name: "JEDEX", company_name: "JEDEX DISTRIBUICOES LTDA", domain: "jedex.com.br", registration_number: "34021316000103", full_address: "Rua dos Andares, 294")

    user = User.create!(email: "joao@jedex.com.br", password:"123456")
    login_as(user, scope: :user)

    visit(root_path)

    click_on("Prazos de envio")

    click_on("Cadastrar novo prazo")

    fill_in "Quilômetros Mínimo",	with: "5"
    fill_in "Quilômetros Máximo",	with: "1"
    fill_in "Prazo", with: "-4"

    click_on("Salvar")

    expect(page).to have_field("Quilômetros Mínimo", with: "5")
    expect(page).to have_field("Quilômetros Máximo", with: "1")
    expect(page).to have_field("Prazo", with: "-4")

    expect(page).to have_content("Prazo deve ser maior ou igual a 0")
    expect(page).to have_content("Quilômetros Máximo deve ser maior que o Quilômetro Mínimo")
  end
end
