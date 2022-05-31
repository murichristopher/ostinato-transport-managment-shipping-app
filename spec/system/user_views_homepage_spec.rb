require 'rails_helper'

describe 'Usuário visualiza página inicial' do
  it 'não autenticado' do
    visit(root_path)

    within("nav") do
      expect(page).to have_content("Home")
      expect(page).to have_content("Entrar")
    end

    within(".container") do
      expect(page).to have_content("Olá")
      expect(page).to have_content("Consultar Ordem de Serviço")
      expect(page).not_to have_content("Ver transportadoras")
      expect(page).not_to have_content("Ver veículos")

    end
  end

  it 'autenticado como User linkado á uma transportadora' do
    transport_company = TransportCompany.create!(trading_name: "SEDEX", company_name: "SEDEX DISTRIBUICOES LTDA", domain: "sedex.com.br", registration_number: "34028316000103", full_address: "Rua dos Andares, 294")

    user = User.create!(email:"fernandinho@sedex.com.br", password:"123456")
    login_as(user, scope: :user)

    visit(root_path)

    within("nav") do
      expect(page).to have_content("Home")
      expect(page).to have_content("fernandinho@sedex.com.br")
      expect(page).to have_content("Usuário")
      expect(page).not_to have_content("Admin")
      expect(page).to have_content("Sair")
    end

    within(".container") do
      expect(page).to have_content("Olá")
      expect(page).to have_content("Consultar Ordem de Serviço")
      expect(page).to have_content("Cadastrar veículo")
      expect(page).to have_content("Atualizar preços")
      expect(page).to have_content("Ver veículos")
      expect(page).to_not have_content("Ver transportadoras")
    end
  end

  it 'autenticado como User não-linkado á uma transportadora' do
    transport_company = TransportCompany.create!(trading_name: "SEDEX", company_name: "SEDEX DISTRIBUICOES LTDA", domain: "sedex.com.br", registration_number: "34028316000103", full_address: "Rua dos Andares, 294")

    user = User.create!(email:"fernandinho@teste.com.br", password:"123456")
    login_as(user, scope: :user)

    visit(root_path)

    within("nav") do
      expect(page).to have_content("Home")
      expect(page).to have_content("fernandinho@teste.com.br")
      expect(page).to have_content("Usuário")
      expect(page).to have_content("Sair")
    end

    within(".container") do
      expect(page).to have_content("Olá")
      expect(page).to have_content("Consultar Ordem de Serviço")
      expect(page).not_to have_content("Cadastrar veículo")
      expect(page).not_to have_content("Atualizar preços")
      expect(page).not_to have_content("Ver veículos")
    end
  end

  it 'autenticado como Admin' do
    admin = Admin.create!(email:"joao@sistemadefrete.com.br", password:"123456")
    login_as(admin, scope: :admin)


    visit(root_path)

    within("nav") do
      expect(page).to have_content("Home")
      expect(page).to have_content("joao@sistemadefrete.com.br")
      expect(page).to have_content("Admin")
      expect(page).not_to have_content("Usuário")
      expect(page).to have_content("Sair")
    end

    within(".container") do
      expect(page).to have_content("Ver transportadoras")
      expect(page).to have_content("Fazer orçamento")
      expect(page).not_to have_content("Cadastrar veículo")
      expect(page).not_to have_content("Atualizar preços")
    end
  end
end

