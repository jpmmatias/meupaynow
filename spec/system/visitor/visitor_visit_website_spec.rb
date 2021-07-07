require 'rails_helper'

describe "Visitor visits 'PayNow!' homepage" do
  it 'successfuly' do
    visit root_path

    expect(page).to have_text('PayNow!')
  end
end
