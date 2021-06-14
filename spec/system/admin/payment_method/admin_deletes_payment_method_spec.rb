require 'rails_helper'

describe 'Admin deletes payment methods' do
	it 'successfully' do
		PaymentMethod.create!(name:'Nubank', payment_type: 0, bank_code: 260, tax: 1.0, icon:  fixture_file_upload(Rails.root.join('spec', 'fixtures', 'payment_method_icon.svg')))

		admin_login
        visit payment_methods_path
        expect(page).to have_content('Nubank')

		click_on 'Deletar'

        expect(page).not_to have_content('Nubank')
		expect(PaymentMethod.count).to eq(0)

		expect(current_path).to eq(payment_methods_path)
	end
end