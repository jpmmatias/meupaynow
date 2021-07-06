require 'rails_helper'

describe 'Client admin generate new company token' do
  it 'successufuly' do
    user = client_admin_login
    visit dashboard_index_path
    expect(page).to have_link(user.company.corporate_name)
    click_on(user.company.corporate_name)
    expect(current_path).to eq(company_path(user.company))

    token = user.company.token
    expect(page).to have_content(token)

    expect(page).to have_link('Gerar Novo Token')
    click_on('Gerar Novo Token')

    expect(page).not_to have_content(token)
  end

  it "and normal client don't view generate link" do
    user = client_login
    visit dashboard_index_path
    expect(page).to have_link(user.company.corporate_name)
    click_on(user.company.corporate_name)

    expect(page).to have_content(user.company.token)
    expect(page).not_to have_link('Gerar Novo Token')
  end
end
