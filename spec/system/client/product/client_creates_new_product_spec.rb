require 'rails_helper'
describe 'Client creates products' do
  it 'from dashboard' do
    client_login
    visit dashboard_index_path
    click_on 'Produtos'

    expect(page).to have_link('Criar Produto')
  end

  it 'successfully' do
    client_login
    visit dashboard_index_path
    click_on 'Produtos'
    click_on('Criar Produto')

    fill_in 'Nome', with: 'Curso de Ruby on Rails'
    fill_in 'Preço', with: '30'
    fill_in 'Desconto Para Pix', with: '0'
    fill_in 'Desconto Para Cartão de Crédito', with: '20'
    fill_in 'Desconto Para Boleto', with: '20.5'

    click_on 'Concluir'

    expect(page).to have_content('Curso de Ruby on Rails')
    expect(page).to have_content('R$ 30,00')
    expect(page).to have_content('0%')
    expect(page).to have_content('20%')
    expect(page).to have_content('20,5%')
  end
end
