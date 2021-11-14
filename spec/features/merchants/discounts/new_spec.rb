require 'rails_helper'

RSpec.describe 'new discounts page' do
  before do
    WebMock.allow_net_connect!
    @merchant = create(:merchant)

    visit new_merchant_discount_path(@merchant)
  end

  it 'when I visit a new merchants discount page' do
    expect(current_path).to eq(new_merchant_discount_path(@merchant))
  end

  it 'can create a new discount' do
    
    fill_in :percentage, with: 40
    fill_in :quantity_threshold, with: 20

    click_button "Create Discount"
    expect(current_path).to eq(merchant_discounts_path(@merchant))
  end
end



# When I visit my bulk discounts index
# Then I see a link to create a new discount
# When I click this link
# Then I am taken to a new page where I see a form to add a new bulk discount
# When I fill in the form with valid data
# Then I am redirected back to the bulk discount index
