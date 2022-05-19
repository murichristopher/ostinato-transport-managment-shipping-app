require 'rails_helper'

describe 'Usuário visualiza página inicial' do
  it 'com sucesso' do
    visit(root_path)

    expect(page).to have_content("Welcome!")
  end
end

