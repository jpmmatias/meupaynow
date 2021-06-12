require 'rails_helper'

describe "Admin manage clients status" do
  context "make user inactive" do
    it "successufuly" do
    client = User.create!(
            email: 'lucasgabriel@codeplay.com.br',
            password: 'Senh@1234',
            name: 'Lucas',
            surname: 'Gabriel',
            company: Company.create(cnpj:'86678309000150', corporate_name: 'Code Play', email:'financeiro@codeplay.com.br', address:'Rua das Flores 766',
            ))

    client_admin=User.create!(
              email: 'amanda@codeplay.com.br',
              password: 'Senh@1234',
              name: 'Amanda',
              role: 5,
              surname: 'Lopes',
              company: Company.create(cnpj:'86678309000150', corporate_name: 'Code Play', email:'financeiro@codeplay.com.br', address:'Rua das Flores 766',
          )
        )

    admin1 = admin_login

    admin2 =  User.create!(
        email: 'joaodoe@paynow.com.br',
        password: 'Senh@1234',
        name: 'Joao Doe',
        role: 10)

    visit dashboard_index_path

    expect(page).to have_link('Clientes')

    click_on 'Clientes'

    expect(page).to have_content('Lucas Gabriel')
    expect(page).to have_content('Cliente')
    expect(page).to have_link('Amanda Lopes')
    expect(page).to have_content('Cliente Admin')

    click_on('Lucas Gabriel')

    expect(page).to have_link('Desativar Cliente')
    click_on('Desativar Cliente')

    expect(page).to have_content('Aguardando autorização de outro Admin')

    logout

    login_as admin2, scope: :user

    visit dashboard_index_path

    expect(page).to have_content('Notificações')
    expect(page).to have_content('Pedido de Jane Doe')
    expect(page).to have_content('Desativar Cliente: Lucas Gabriel')
    expect(page).to have_link('Sim')
    expect(page).to have_link('Não')

    click_on('Sim')

    expect(page).to have_content('Cliente desativado com sucesso')
    expect(page).not_to have_content('Desativar Cliente: Lucas Gabriel')

    click_on 'Clientes'
    click_on('Lucas Gabriel')

    expect(page).not_to have_link('Desativar Cliente')
    expect(page).to have_link('Ativar Cliente')

    end
  end
end
