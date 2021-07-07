require 'rails_helper'

describe 'Admin create  payment methods' do
  it 'successufuly' do
    admin_login
    visit dashboard_index_path
    click_on('Metodos de Pagamento')

    expect(page).to have_link('Criar Novo Metodo de Pagamento')
    click_on('Criar Novo Metodo de Pagamento')

    fill_in 'Nome', with: 'Nubank'
    fill_in 'Taxa', with: '1'
    fill_in 'Código do Banco', with: '266'
    select 'Pix', from: 'Tipo de Pagamento'
    check('Ativo')
    attach_file 'Icone',
                Rails.root.join('spec/fixtures/payment_method_icon.svg')

    click_on('Concluir')

    expect(current_path).to eq(payment_methods_path)

    expect(page).to have_content('Nubank')
    expect(page).to have_content('Pix')
    expect(page).to have_content('266')
    expect(page).to have_content('1%')
    expect(page).to have_css('img[src*="payment_method_icon.svg"]')
    expect(page).to have_content('Ativo')
  end

  it "and attributes can't be blank" do
    admin_login
    visit new_payment_method_path

    click_on('Concluir')

    expect(page).to have_content('não pode ficar em branco', count: 3)
  end
end
