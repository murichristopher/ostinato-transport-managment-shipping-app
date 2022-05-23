require 'rails_helper'

describe 'Usuário visualiza página inicial' do
  it 'não autenticado' do
    visit(root_path)

    within("nav") do
      expect(page).to have_content("Home")
      expect(page).to have_content("Entrar")
    end
  end

  it 'autenticado como User' do
    user = User.create!(email:"joao@gmail.com", password:"123456")
    login_as(user, scope: :user)


    visit(root_path)

    within("nav") do
      expect(page).to have_content("Home")
      expect(page).to have_content("joao@gmail.com")
      expect(page).to have_content("Usuário")
      expect(page).to have_content("Sair")
    end
  end

  it 'autenticado como Admin' do
    admin = Admin.create!(email:"joao@sistemadefrete.com.br", password:"123456")
    login_as(admin, scope: :admin)


    visit(root_path)

    within("nav") do
      expect(page).to have_content("Home")
      expect(page).to have_content("joao@sistemadefrete.com.br")
      expect(page).to have_content("Admin")
      expect(page).to have_content("Sair")
    end
  end
end

