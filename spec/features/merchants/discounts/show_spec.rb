require 'rails_helper'

RSpec.describe 'discount show page' do
  before do
    WebMock.allow_net_connect!
    @merchant = create(:merchant)
    @discount1 = Discount.create!(percentage: 20, quantity_threshold: 10, merchant_id: @merchant.id)

    visit merchant_discount_path(@merchant, @discount1)
  end

  it 'can show bulk discount percentage and quantity threshold' do
    expect(page).to have_content(@merchant.name)
    expect(page).to have_content(@discount1.percentage)
    expect(page).to have_content(@discount1.quantity_threshold)
  end

  it 'has a link to edit a discount' do
    click_link "Edit Discount"
    expect(current_path).to eq(edit_merchant_discount_path(@merchant, @discount1))
  end
end


# As a merchant
# When I visit my bulk discount show page
# Then I see a link to edit the bulk discount
# When I click this link
# Then I am taken to a new page with a form to edit the discount
# And I see that the discounts current attributes are pre-poluated in the form
# When I change any/all of the information and click submit
# Then I am redirected to the bulk discount's show page
# And I see that the discount's attributes have been updated
