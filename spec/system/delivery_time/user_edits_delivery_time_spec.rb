require 'rails_helper'

describe 'Usuário edita prazos de envio' do
  it 'com sucesso' do
    transport_company = TransportCompany.create!(trading_name: "JEDEX", company_name: "JEDEX DISTRIBUICOES LTDA", domain: "jedex.com.br", registration_number: "34021316000103", full_address: "Rua dos Andares, 294")

    DeliveryTime.create!(km_min:1, km_max: 49, time: 2, transport_company_id: 1)
    DeliveryTime.create!(km_min:50, km_max: 100, time: 7, transport_company_id: 1)

    user = User.create!(email: "joao@jedex.com.br", password:"123456")
    login_as(user, scope: :user)

    visit(root_path)

    click_on("Prazos de envio")

    within(".t-line1") do
      click_on("Editar")
    end

    fill_in "Quilômetros Mínimo",	with: "6"
    fill_in "Quilômetros Máximo",	with: "8"
    fill_in "Prazo", with: "45"

    click_on("Salvar")

    within("table") do
      expect(page).to have_content("6km á 8km 45 dias úteis")
      expect(page).not_to have_content("50km á 100km 7 dias úteis")
    end
  end
  it 'com dados incompletos ou inválidos' do
    transport_company = TransportCompany.create!(trading_name: "JEDEX", company_name: "JEDEX DISTRIBUICOES LTDA", domain: "jedex.com.br", registration_number: "34021316000103", full_address: "Rua dos Andares, 294")

    DeliveryTime.create!(km_min:1, km_max: 49, time: 2, transport_company_id: 1)
    DeliveryTime.create!(km_min:50, km_max: 100, time: 7, transport_company_id: 1)

    user = User.create!(email: "joao@jedex.com.br", password:"123456")
    login_as(user, scope: :user)

    visit(root_path)

    click_on("Prazos de envio")

    within(".t-line1") do
      click_on("Editar")
    end

    fill_in "Quilômetros Mínimo",	with: "55"
    fill_in "Quilômetros Máximo",	with: "20"
    fill_in "Prazo", with: ""

    click_on("Salvar")

    expect(page).to have_content("Prazo não pode ficar em branco")
    expect(page).to have_content("Quilômetros Máximo deve ser maior que o Quilômetro Mínimo")
  end
end
