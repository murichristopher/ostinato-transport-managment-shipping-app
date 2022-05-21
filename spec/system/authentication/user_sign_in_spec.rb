require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com suceso' do
    User.create!(email:"joaoaguialr@gmail.com", password:"password")

    visit(root_path)

    within("nav") do
     click_on("Entrar")
    end

    fill_in("Email", with:"joaoaguialr@gmail.com")
    fill_in("Password", with:"password")
    click_on("Log in")

    expect(page).to have_content("Signed in successfully.")

    within("nav") do
      expect(page).to have_content("joaoaguialr@gmail.com")
      expect(page).to_not have_content("Entrar")
      expect(page).to have_content("Sair")
    end

  end
end
