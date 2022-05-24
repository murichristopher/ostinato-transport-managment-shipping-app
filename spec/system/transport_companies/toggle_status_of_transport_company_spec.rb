require 'rails_helper'

describe "Administrador altera o estado de um transportadora" do
  it 'para inativa' do
    transport_company = TransportCompany.create!(trading_name: "SEDEX", company_name: "SEDEX DISTRIBUICOES LTDA", domain: "sedex.com.br", registration_number: "34028316000103", full_address: "Rua dos Andares, 294")

    admin = Admin.create!(email:"joao@sistemadefrete.com.br", password:"123456")
    login_as(admin, scope: :admin)
    visit(root_path)

    click_on("Ver transportadoras")

    within(".card") do
      click_on("SEDEX")
    end


    click_on("Desativar")
    transport_company.reload

    within(".navigation-area") do
      expect(page).to have_content("INATIVO")
    end
    expect(transport_company).to be_inactive
  end
   it 'para ativa' do
    transport_company = TransportCompany.create!(trading_name: "SEDEX", company_name: "SEDEX DISTRIBUICOES LTDA", domain: "sedex.com.br", registration_number: "34028316000103", full_address: "Rua dos Andares, 294", status: "inactive")

    admin = Admin.create!(email:"joao@sistemadefrete.com.br", password:"123456")
    login_as(admin, scope: :admin)
    visit(root_path)

    click_on("Ver transportadoras")

    within(".card") do
      click_on("SEDEX")
    end

    click_on("Ativar")
    transport_company.reload

    within(".navigation-area") do
      expect(page).to have_content("ATIVO")
    end
    expect(transport_company).to be_active
  end
end

