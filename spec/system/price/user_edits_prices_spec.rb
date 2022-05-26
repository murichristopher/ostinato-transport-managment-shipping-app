require 'rails_helper'

describe 'Usuário edita um preço' do
  it 'com sucesso' do
    transport_company = TransportCompany.create!(trading_name: "SEDEX", company_name: "SEDEX DISTRIBUICOES LTDA", domain: "sedex.com.br", registration_number: "34028316000103", full_address: "Rua dos Andares, 294")

    Price.create!(cubic_meters_min: 0.001, cubic_meters_max: 0.900, weight_min:0.1, weight_max:29.99, value_per_km:3.25, transport_company:transport_company)
    Price.create!(cubic_meters_min: 0.001, cubic_meters_max: 2.900, weight_min:30, weight_max:100, value_per_km:7.25, transport_company:transport_company)

    user = User.create!(email:"joao@sedex.com.br", password:"123456")
    login_as(user, scope: :user)

    visit(root_path)

    click_on("Ver preços")

    within(".t-line1") do
      click_on("Editar")
    end

    fill_in("Metros Cúbicos Mínimo", with:0.005)
    fill_in("Metros Cúbicos Máximo", with:0.5)
    fill_in("Peso Mínimo", with:0.1)
    fill_in("Peso Máximo", with:29.9)
    fill_in("Valor por Km", with:2.75)

    click_on("Salvar")

    expect(page).to have_content("Preço editado com sucesso!")

    within("table") do
      expect(page).to have_content("0.005m³ á 0.5m³ 0.1kg á 29.9kg R$2.75")
      expect(page).not_to have_content("0.001m³ á 2.9m³ 30.0kg á 100.0kg R$7.25")
      expect(page).to have_content("0.001m³ á 0.9m³ 0.1kg á 29.99kg R$3.25")
    end
  end

  it 'com dados incompletos ou inválidos' do
     transport_company = TransportCompany.create!(trading_name: "SEDEX", company_name: "SEDEX DISTRIBUICOES LTDA", domain: "sedex.com.br", registration_number: "34028316000103", full_address: "Rua dos Andares, 294")

    Price.create!(cubic_meters_min: 0.001, cubic_meters_max: 0.900, weight_min:0.1, weight_max:29.99, value_per_km:3.25, transport_company:transport_company)
    Price.create!(cubic_meters_min: 0.001, cubic_meters_max: 2.900, weight_min:30, weight_max:100, value_per_km:7.25, transport_company:transport_company)

    user = User.create!(email:"joao@sedex.com.br", password:"123456")
    login_as(user, scope: :user)

    visit(root_path)

    click_on("Ver preços")

    within(".t-line1") do
      click_on("Editar")
    end


    fill_in("Metros Cúbicos Mínimo", with:0.020)
    fill_in("Metros Cúbicos Máximo", with:0.010)
    fill_in("Valor por Km", with:-5)

    click_on("Salvar")
    expect(page).to have_field("Metros Cúbicos Mínimo", with:0.020)
    expect(page).to have_field("Metros Cúbicos Máximo", with:0.010)
    expect(page).to have_field("Peso Mínimo", with:30.0)
    expect(page).to have_field("Peso Máximo", with:100.0)
    expect(page).to have_field("Valor por Km", with:-5)


    expect(page).to have_content("Metros Cúbicos Máximo deve ser maior que o Metros Cúbicos Mínimo")
    expect(page).to have_content("Valor por Km deve ser maior ou igual a 0")
  end
end
