# Ostinato#
##### Sistema de gerenciamento e controle de envios de transportadoras.

Este é um projeto que está em desenvolvimento durante o bootcamp da Campus Code [Campus Code](https://campuscode.com.br/), o [TreinaDev](https://treinadev.com.br), sendo este o seu projeto *final* da 1º etapa. 

### Versões
- Ruby 3.0.4
- Rails 7.0.3
- Sqlite 2.8.17

Funcionalidades

### Dependências
- [RSpec](https://rubygems.org/gems/rspec): É uma ferramente de teste para Rails, criada para (BDD) e sendo utilizada também como ferramenta (TDD)
- [Capybara](https://rubygems.org/gems/capybara): Utilizada para testes, possibilitando simular como um usuário interagiria com um website.
- [Devise](https://rubygems.org/gems/devise): Solução flexível e modular para gerenciar autenticações.
- [FriendlyID](https://rubygems.org/gems/friendly_id): Permite a criação de URLs com strings amigáveis, ao invés de ID's numéricos.

# Executando o projeto
1. Clone o repositório
  ```
  git clone https://github.com//.git
  ```
2. Entre na pasta e instale as dependências
  ```
  cd /
  bin/setup
  bundle install
  ```
3. Execute as migrações
  ```
  rails db:migrate
  ```
4. Adicione dados ao banco 
  ```
  rails db:seed
  # `rails db:reset` para resetar
  # DB pré-criada apenas por demonstração. Poderá acessá-lá em db/seeds.rb
  ```
5. Rode o servidor em http://localhost:3000/
  ```
  rails server
  ```

# Andamento do Projeto
[github.com/murichristopher](https://github.com/)# README


