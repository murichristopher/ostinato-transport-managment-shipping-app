require 'rails_helper'

describe 'Admin faz orçamento de preços' do
  it 'e vê apenas transportadoras ativas' do
    transport_company = TransportCompany.create!(trading_name: "SEDEX", company_name: "SEDEX DISTRIBUICOES LTDA", domain: "sedex.com.br", registration_number: "34028316000103", full_address: "Rua dos Andares, 294")
    second_transport_company = TransportCompany.create!(trading_name: "TEDEX", company_name: "TEDEX DISTRIBUICOES LTDA", domain: "tedex.com.br", registration_number: "12028316000103", full_address: "Rua dos Andares, 294")
    third_transport_company = TransportCompany.create!(trading_name: "REDEX", company_name: "REDEX DISTRIBUICOES LTDA", domain: "redex.com.br", registration_number: "12028316000123", full_address: "Rua dos Andares, 294")


    admin = Admin.create!(email:"joao@sistemadefrete.com.br", password:"123456")
    login_as(admin, scope: :admin)

    Price.create!(cubic_meters_min: 0.001, cubic_meters_max: 0.900, weight_min:0.1, weight_max:29.99, value_per_km:3.25, transport_company:transport_company)
    Price.create!(cubic_meters_min: 0.001, cubic_meters_max: 2.900, weight_min:30, weight_max:100, value_per_km:7.25, transport_company:transport_company)
    DeliveryTime.create!(km_min:1, km_max: 49, time: 2, transport_company: transport_company)
    DeliveryTime.create!(km_min:50, km_max: 100, time: 7, transport_company: transport_company)

    Price.create!(cubic_meters_min: 0.001, cubic_meters_max: 0.900, weight_min:0.1, weight_max:29.99, value_per_km:23.25, transport_company:second_transport_company)
    Price.create!(cubic_meters_min: 0.001, cubic_meters_max: 2.900, weight_min:30, weight_max:100, value_per_km:11.25, transport_company:second_transport_company)
    DeliveryTime.create!(km_min:1, km_max: 49, time: 2, transport_company: second_transport_company)
    DeliveryTime.create!(km_min:50, km_max: 100, time: 6, transport_company: second_transport_company)

    Price.create!(cubic_meters_min: 0.001, cubic_meters_max: 0.900, weight_min:0.1, weight_max:29.99, value_per_km:23.25, transport_company:third_transport_company)
    Price.create!(cubic_meters_min: 0.001, cubic_meters_max: 2.900, weight_min:30, weight_max:100, value_per_km:11.25, transport_company:third_transport_company)
    DeliveryTime.create!(km_min:1, km_max: 49, time: 2, transport_company: third_transport_company)
    DeliveryTime.create!(km_min:50, km_max: 100, time: 6, transport_company: third_transport_company)

    visit(root_path)

    click_on("Ver transportadoras")

    click_on("TEDEX")

    click_on("Desativar")

    visit(root_path)

    click_on("Fazer orçamento")

    fill_in "Metros Cúbicos",	with: 1
    fill_in "Peso Total",	with: 30
    fill_in "Distância Total",	with: 60
    click_on("Enviar")

    expect(page).not_to have_content("Transportadoras disponíveis: 3")
    expect(page).to have_content("Transportadoras disponíveis: 2")

    within(".b-line0") do
      expect(page).to have_content("SEDEX DISTRIBUICOES LTDA Valor: R$ 435,00 Tempo Estimado de Envio: 7 dias úteis")
      expect(page).to have_button("Cadastrar Ordem de Serviço")
    end

    within(".b-line1") do
      expect(page).not_to have_content("TEDEX DISTRIBUICOES LTDA Valor: R$ 675,00 Tempo Estimado de Envio: 6 dias úteis")
    end

    within(".b-line1") do
      expect(page).to have_content("REDEX DISTRIBUICOES LTDA Valor: R$ 675,00 Tempo Estimado de Envio: 6 dias úteis")
      expect(page).to have_button("Cadastrar Ordem de Serviço")
    end

  end

  it 'sem nenhuma transportadora á suprir os requisitos' do
transport_company = TransportCompany.create!(trading_name: "SEDEX", company_name: "SEDEX DISTRIBUICOES LTDA", domain: "sedex.com.br", registration_number: "34028316000103", full_address: "Rua dos Andares, 294")
    second_transport_company = TransportCompany.create!(trading_name: "TEDEX", company_name: "TEDEX DISTRIBUICOES LTDA", domain: "tedex.com.br", registration_number: "12028316000103", full_address: "Rua dos Andares, 294")
    third_transport_company = TransportCompany.create!(trading_name: "REDEX", company_name: "REDEX DISTRIBUICOES LTDA", domain: "redex.com.br", registration_number: "12028316000123", full_address: "Rua dos Andares, 294")


    admin = Admin.create!(email:"joao@sistemadefrete.com.br", password:"123456")
    login_as(admin, scope: :admin)

    Price.create!(cubic_meters_min: 0.001, cubic_meters_max: 0.900, weight_min:0.1, weight_max:29.99, value_per_km:3.25, transport_company:transport_company)
    Price.create!(cubic_meters_min: 0.001, cubic_meters_max: 2.900, weight_min:30, weight_max:100, value_per_km:7.25, transport_company:transport_company)
    DeliveryTime.create!(km_min:1, km_max: 49, time: 2, transport_company: transport_company)
    DeliveryTime.create!(km_min:50, km_max: 100, time: 7, transport_company: transport_company)


    visit(root_path)

    click_on("Fazer orçamento")

    fill_in "Metros Cúbicos",	with: 1123
    fill_in "Peso Total",	with: 301
    fill_in "Distância Total",	with: 60123
    click_on("Enviar")

    expect(page).to have_content("Nenhuma transportadora possui preços com os requisitos informados.")
  end

end
