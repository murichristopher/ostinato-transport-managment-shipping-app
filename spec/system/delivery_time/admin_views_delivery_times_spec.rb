describe 'Admin visualiza prazos de envio' do
  it 'com sucesso' do
    transport_company = TransportCompany.create!(trading_name: "JEDEX", company_name: "JEDEX DISTRIBUICOES LTDA", domain: "jedex.com.br", registration_number: "34021316000103", full_address: "Rua dos Andares, 294")

    DeliveryTime.create!(km_min:1, km_max: 49, time: 2, transport_company_id: 1)
    DeliveryTime.create!(km_min:50, km_max: 100, time: 7, transport_company_id: 1)

    admin = Admin.create!(email: "joao@sistemadefrete.com.br", password:"123456")
    login_as(admin, scope: :admin)

    visit(root_path)
    click_on("Ver transportadoras")

    click_on("JEDEX")

    expect(page).to have_content("Prazos de envio")
    expect(page).to have_content("1km á 49km 2 dias úteis")
    expect(page).to have_content("50km á 100km 7 dias úteis")

  end

  it 'sem nenhum cadastrado' do
    transport_company = TransportCompany.create!(trading_name: "JEDEX", company_name: "JEDEX DISTRIBUICOES LTDA", domain: "jedex.com.br", registration_number: "34021316000103", full_address: "Rua dos Andares, 294")

    admin = Admin.create!(email: "joao@sistemadefrete.com.br", password:"123456")
    login_as(admin, scope: :admin)

    visit(root_path)
    click_on("Ver transportadoras")

    click_on("JEDEX")

    expect(page).to have_content("Prazos de envio")

    expect(page).to have_content("Nenhum prazo de envio cadastrado")
  end
end
