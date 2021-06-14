require 'rails_helper'
describe 'Client view products' do


	it 'successfully' do
		client = client_login
        Product.create!(name:"Produto 1", value:30.0, discount_pix:20, discount_boleto:0, discount_credit:99.7, company: client.company)
		visit dashboard_index_path
		click_on 'Produtos'

		expect(page).to have_content('Produto 1')
		expect(page).to have_content('R$ 30,00')
        expect(page).to have_content('0%')
        expect(page).to have_content('20%')
        expect(page).to have_content('99,7%')

	end




end