require 'rails_helper'

describe 'Client admin view company token' do
		it 'successufuly' do
			user = client_admin_login
            visit dashboard_index_path
            expect(page).to have_link(user.company.corporate_name)

            click_on(user.company.corporate_name)

            expect(current_path).to eq(company_path(user.company))

            expect(page).to have_content(user.company.token)
		end
end