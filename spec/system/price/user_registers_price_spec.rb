require 'rails_helper'

describe 'Usuário cadastra um preço' do
  it 'com sucesso' do
    transport_company = TransportCompany.create!(trading_name: "SEDEX", company_name: "SEDEX DISTRIBUICOES LTDA", domain: "sedex.com.br", registration_number: "34028316000103", full_address: "Rua dos Andares, 294")

    user = User.create!(email:"joao@sedex.com.br", password:"123456")
    login_as(user, scope: :user)

    visit(root_path)

    click_on("Ver preços")

    click_on("Cadastrar novo preço")

    fill_in("Metros Cúbicos Mínimo", with:0.005)
    fill_in("Metros Cúbicos Máximo", with:0.5)
    fill_in("Peso Mínimo", with:0.1)
    fill_in("Peso Máximo", with:29.9)
    fill_in("Valor por Km", with:2.75)

    click_on("Salvar")

    expect(page).to have_content("Preço cadastrado com sucesso!")

    within("table") do
      expect(page).to have_content("0.005m³ á 0.5m³")
      expect(page).to have_content("0.1kg á 29.9kg")
      expect(page).to have_content("R$2.75")
    end
  end

  it 'com dados incompletos ou inválidos' do
     transport_company = TransportCompany.create!(trading_name: "SEDEX", company_name: "SEDEX DISTRIBUICOES LTDA", domain: "sedex.com.br", registration_number: "34028316000103", full_address: "Rua dos Andares, 294")

    user = User.create!(email:"joao@sedex.com.br", password:"123456")
    login_as(user, scope: :user)

    visit(root_path)

    click_on("Ver preços")

    click_on("Cadastrar novo preço")

    fill_in("Metros Cúbicos Mínimo", with:0.020)
    fill_in("Metros Cúbicos Máximo", with:0.010)
    fill_in("Peso Máximo", with:9.9)
    fill_in("Valor por Km", with:-5)

    click_on("Salvar")
    expect(page).to have_field("Metros Cúbicos Mínimo", with:0.020)
    expect(page).to have_field("Metros Cúbicos Máximo", with:0.010)
    expect(page).to have_field("Peso Mínimo", with:"")
    expect(page).to have_field("Peso Máximo", with:9.9)

    expect(page).to have_field("Valor por Km", with:-5)


    expect(page).to have_content("Peso Mínimo não pode ficar em branco")
    expect(page).to have_content("Metros Cúbicos Máximo deve ser maior que o Metros Cúbicos Mínimo")
    expect(page).to have_content("Valor por Km deve ser maior ou igual a 0")

  end
end
