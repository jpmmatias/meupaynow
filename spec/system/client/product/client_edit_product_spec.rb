require 'rails_helper'
describe 'Client edits products' do
  it 'successfully' do
    client = client_login
    Product.create!(name: 'Produto 1', value: 30.0, discount_pix: 20,
                    discount_boleto: 0, discount_credit: 99.7, company: client.company)
    visit dashboard_index_path

    click_on 'Produtos'
    expect(page).to have_content('Editar')
    click_on('Editar')

    fill_in 'Nome', with: 'Curso de Elixir'
    fill_in 'Preço', with: '20'
    fill_in 'Desconto Para Pix', with: '10'
    fill_in 'Desconto Para Cartão de Crédito', with: '22'
    fill_in 'Desconto Para Boleto', with: '21.5'

    click_on 'Concluir'

    expect(page).to have_content('Curso de Elixir')
    expect(page).to have_content('R$ 20,00')
    expect(page).to have_content('10%')
    expect(page).to have_content('22%')
    expect(page).to have_content('21,5%')
  end

  it 'client view all updates from products' do
    client = client_login
    product = Product.create!(name: 'Produto 1', value: 30.0,
                              discount_pix: 20, discount_boleto: 0, discount_credit: 99.7, company: client.company)
    product.update!(name: 'Produto 1.2')
    product.update!(name: 'Produto 1.3')
    product.update!(name: 'Produto 1.4')

    visit company_product_path(client.company, product)
    expect(page).to have_content('Produto 1')
    expect(page).to have_content('Produto 1.2')
    expect(page).to have_content('Produto 1.3')
    expect(page).to have_content('Produto 1.4')
  end
end
