require 'rails_helper'

describe 'Usuário edita prazos de envio' do
  it 'e não afeta os demais' do
    transport_company = TransportCompany.create!(trading_name: "JEDEX", company_name: "JEDEX DISTRIBUICOES LTDA", domain: "jedex.com.br", registration_number: "34021316000103", full_address: "Rua dos Andares, 294")

    DeliveryTime.create!(km_min:1, km_max: 49, time: 2, transport_company_id: 1)
    DeliveryTime.create!(km_min:50, km_max: 100, time: 7, transport_company_id: 1)

    user = User.create!(email: "joao@jedex.com.br", password:"123456")
    login_as(user, scope: :user)

    visit(root_path)

    click_on("Prazos de envio")

    within(".t-line1") do
      click_on("Deletar")
    end

    within("table") do
      expect(page).not_to have_content("50km á 100km 7 dias úteis")
      expect(page).to have_content("1km á 49km 2 dias úteis")
    end
  end
end
