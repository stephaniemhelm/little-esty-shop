require 'rails_helper'

RSpec.describe 'Merchant index page' do
  it 'has project title' do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    merchant3 = create(:merchant)

    visit '/merchants'

    expect(page).to have_content(merchant1.name)
    expect(page).to have_content(merchant2.name)
    expect(page).to have_content(merchant3.name)
  end
end
