require 'rails_helper'

describe "Admin edita uma transportadora" do
  it 'com sucesso' do
    transport_company = TransportCompany.create!(trading_name: "SEDEX", company_name: "SEDEX DISTRIBUICOES LTDA", domain: "sedex.com.br", registration_number: "34028316000103", full_address: "Rua dos Andares, 294")

    admin = Admin.create!(email:"joao@sistemadefrete.com.br", password:"123456")
    login_as(admin, scope: :admin)
    visit(root_path)

    click_on("Ver transportadoras")

    within(".card") do
      click_on("SEDEX")
    end

    click_on("Editar")

    fill_in("Nome Fantasia", with:"AMEX")
    fill_in("Razão Social", with:"AMEX CORREIOS LTDA")
    fill_in("Domínio", with:"amex.com.br")
    fill_in("CNPJ", with:"34028316000103")
    fill_in("Endereço", with:"Av. Quinze de Novembro, 165 - Sítio Paredao, Ferraz de Vasconcelos - SP, 08500-405")

    click_on("Salvar")

    expect(page).to have_content("Transportadora editada com sucesso!")
    expect(page).to have_content("AMEX")
    expect(page).to have_content("AMEX CORREIOS LTDA")
    expect(page).to have_content("amex.com.br")
    expect(page).to have_content("AMEX")
    expect(page).to have_content("Av. Quinze de Novembro, 165 - Sítio Paredao, Ferraz de Vasconcelos - SP, 08500-405")
  end

  it 'com dados incompletos ou inválidos' do
    transport_company = TransportCompany.create!(trading_name: "SEDEX", company_name: "SEDEX DISTRIBUICOES LTDA", domain: "sedex.com.br", registration_number: "34028316000103", full_address: "Rua dos Andares, 294")

    admin = Admin.create!(email:"joao@sistemadefrete.com.br", password:"123456")
    login_as(admin, scope: :admin)
    visit(root_path)

    click_on("Ver transportadoras")

    within(".card") do
      click_on("SEDEX")
    end

    click_on("Editar")

    fill_in("Nome Fantasia", with:"")
    fill_in("Razão Social", with:"AMEX DISTRIBUIÇÕES")
    fill_in("Domínio", with:"amex.com.br")
    fill_in("CNPJ", with:"sdsadsadsadas")
    fill_in("Endereço", with:"")

    click_on("Salvar")

    expect(page).to have_content("Nome Fantasia não pode ficar em branco")
    expect(page).to have_content("CNPJ não é válido")
    expect(page).to have_content("Endereço completo não pode ficar em branco")
  end
end

