require 'rails_helper'

describe "Admin registra uma transportadora" do
  it 'com sucesso' do
    admin = Admin.create!(email:"joao@sistemadefrete.com.br", password:"123456")
    login_as(admin, scope: :admin)

    visit("/")

    click_on("Transportadoras")

    click_on("Cadastrar Transportadora")

    fill_in("Nome Fantasia", with:"AMEX")
    fill_in("Razão Social", with:"AMEX CORREIOS LTDA")
    fill_in("Domínio", with:"amex.com.br")
    fill_in("CNPJ", with:"34028316000103")
    fill_in("Endereço", with:"Av. Quinze de Novembro, 165 - Sítio Paredao, Ferraz de Vasconcelos - SP, 08500-405")

    click_on("Salvar")

    expect(page).to have_content("Transportadora cadastrada com sucesso!")
    expect(page).to have_content("AMEX")
    expect(page).to have_content("AMEX CORREIOS LTDA")
    expect(page).to have_content("amex.com.br")
    expect(page).to have_content("AMEX")
    expect(page).to have_content("Av. Quinze de Novembro, 165 - Sítio Paredao, Ferraz de Vasconcelos - SP, 08500-405")

  end

  it 'com dados incompletos ou inválidos' do
admin = Admin.create!(email:"joao@sistemadefrete.com.br", password:"123456")
    login_as(admin, scope: :admin)

    visit("/")

    click_on("Transportadoras")

    click_on("Cadastrar Transportadora")

    fill_in("Nome Fantasia", with:"AMEX")
    fill_in("Razão Social", with:"")
    fill_in("Domínio", with:"amex.com.br")
    fill_in("CNPJ", with:"sdsadsadsadas")
    fill_in("Endereço", with:"")

    click_on("Salvar")

    expect(page).to have_content("Razão Social não pode ficar em branco")
    expect(page).to have_content("CNPJ não é válido")
    expect(page).to have_content("Endereço completo não pode ficar em branco")
  end
end

