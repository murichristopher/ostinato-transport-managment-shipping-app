require 'rails_helper'

describe 'Usuário se cadastra' do
  it 'com sucesso' do
    visit(root_path)

    click_on("Entrar")
    click_on("Sign up")

    fill_in("Email", with:"gabriel@gmail.com")
    fill_in("Password", with:"123456")
    fill_in("Password confirmation", with:"123456")
    click_on("Sign up")

    user = User.last

    expect(user.email).to eq("gabriel@gmail.com")

    within("nav") do
      expect(page).to have_content("gabriel@gmail.com")
      expect(page).to have_content("Sair")
      expect(page).to_not have_content("Entrar")
    end

    expect(page).to have_content("Welcome! You have signed up successfully.")

  end
end
