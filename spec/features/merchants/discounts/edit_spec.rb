require 'rails_helper'

RSpec.describe 'edit discount' do
  before do
    WebMock.allow_net_connect!
    @merchant = create(:merchant)
    @discount1 = Discount.create!(percentage: 20, quantity_threshold: 10, merchant_id: @merchant.id)

    visit edit_merchant_discount_path(@merchant, @discount1)
  end

  it 'can edit a discount' do
    fill_in :percentage, with: 40
    fill_in :quantity_threshold, with: 20

    click_button "Submit"

    expect(current_path).to eq(merchant_discounts_path(@merchant))
    expect(page).to_not have_content("Discount percentage: #{@discount1.percentage}%")
    expect(page).to_not have_content("Quantity Threshold: #{@discount1.quantity_threshold}")
  end

  it 'can flash error message' do
    fill_in :percentage, with: 40
    fill_in :quantity_threshold, with: 0

    click_button "Submit"

    expect(current_path).to eq(edit_merchant_discount_path(@merchant, @discount1))
    expect(page).to have_content("Please enter a valid information")
  end
end
