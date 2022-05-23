require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do
    User.create!(email:"joaoaguialr@gmail.com", password:"password")

    visit(root_path)

    within("nav") do
     click_on("Entrar")
    end

    fill_in("E-mail", with:"joaoaguialr@gmail.com")
    fill_in("Senha", with:"password")
    click_on("Login")

    expect(page).to have_content("Login efetuado com sucesso.")

    within("nav") do
      expect(page).to have_content("joaoaguialr@gmail.com")
      expect(page).to have_content("Usuário")
      expect(page).to_not have_content("Entrar")
      expect(page).to have_content("Sair")
    end

  end
end
