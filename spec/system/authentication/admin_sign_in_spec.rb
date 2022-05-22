require 'rails_helper'

describe 'Admin se autentica' do
  it 'com sucesso' do
    Admin.create!(email:"joaoaguialr@admin.com", password:"password")

    visit(root_path)

    within("nav") do
     click_on("Entrar")
    end

    click_on("Entrar como Admin")

    fill_in("E-mail", with:"joaoaguialr@admin.com")
    fill_in("Senha", with:"password")
    click_on("Login")

    expect(page).to have_content("Login efetuado com sucesso.")

    within("nav") do
      expect(page).to have_content("Admin")
      expect(page).to have_content("joaoaguialr@admin.com")
      expect(page).to_not have_content("Entrar")
      expect(page).to have_content("Sair")
    end

  end
end
