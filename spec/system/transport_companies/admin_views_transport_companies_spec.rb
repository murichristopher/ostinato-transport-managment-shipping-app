require 'rails_helper'

describe 'Usuário visualiza transportadoras' do
  it 'apenas se for Administrador' do
    user = User.create!(email:"joaoaguialr@gmail.com", password:"password")
    login_as(user, scope: :user)

    visit(root_path)

    expect(page).not_to have_content("Transportadoras")
  end

  it 'com sucesso' do
    TransportCompany.create!(trading_name: "SEDEX", company_name: "SEDEX DISTRIBUICOES LTDA", domain: "sedex.com.br", registration_number: "34028316000103", full_address: "Rua dos Andares, 294")

    admin = Admin.create!(email:"joao@sistemadefrete.com.br", password:"123456")
    login_as(admin, scope: :admin)
    visit(root_path)

    click_on("Transportadoras")

    expect(page).to have_content("SEDEX")
    expect(page).to have_content("SEDEX DISTRIBUICOES LTDA")
    expect(page).to have_content("34028316000103")
    expect(page).to have_content("sedex.com.br")
  end

  it 'sem nenhuma cadastrada' do
    admin = Admin.create!(email:"joao@sistemadefrete.com.br", password:"123456")
    login_as(admin)

    visit(root_path)
    click_on("Transportadoras")

    expect(page).to have_content("Nenhuma transportadora cadastrada")
  end
end
