require 'rails_helper'

describe 'Admin se cadastra' do
  it 'com sucesso' do
    visit(root_path)

    click_on("Entrar")

    click_on("Entrar como Admin")
    click_on("Inscrever-se")

    fill_in("E-mail", with:"gabriel@admin.com")
    fill_in("Senha", with:"123456")
    fill_in("Confirme sua senha", with:"123456")

    click_on("Cadastrar-se")

    admin = Admin.last

    expect(admin.email).to eq("gabriel@admin.com")

    within("nav") do
      expect(page).to have_content("gabriel@admin.com")
      expect(page).to have_content("Sair")
      expect(page).to have_content("Admin")
      expect(page).to_not have_content("Entrar")
    end

    expect(page).to have_content("Boas vindas! Você realizou seu registro com sucesso.")

  end
end
