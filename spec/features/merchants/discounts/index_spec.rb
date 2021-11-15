require 'rails_helper'

RSpec.describe 'discounts index page' do
  before do
    WebMock.allow_net_connect!
    @merchant = create(:merchant)

    @discount1 = Discount.create!(percentage: 20, quantity_threshold: 10, merchant_id: @merchant.id)
    @discount2 = Discount.create!(percentage: 30, quantity_threshold: 15, merchant_id: @merchant.id)
    @discount3 = Discount.create!(percentage: 15, quantity_threshold: 5, merchant_id: @merchant.id)

    @customer1 = create :customer
    @customer2 = create :customer
    @customer3 = create :customer
    @customer4 = create :customer
    @customer5 = create :customer
    @customer6 = create :customer

    @item = create :item, { merchant_id: @merchant.id }

    @invoice1 = create :invoice, { customer_id: @customer1.id, status: 'in progress' }
    @invoice2 = create :invoice, { customer_id: @customer2.id, status: 'in progress' }
    @invoice3 = create :invoice, { customer_id: @customer3.id, status: 'in progress' }
    @invoice4 = create :invoice, { customer_id: @customer4.id, status: 'in progress' }
    @invoice5 = create :invoice, { customer_id: @customer5.id, status: 'completed' }
    @invoice6 = create :invoice, { customer_id: @customer6.id, status: 'cancelled' }

    @transaction1 = create :transaction, { invoice_id: @invoice1.id, result: 'success' }
    @transaction2 = create :transaction, { invoice_id: @invoice2.id, result: 'success' }
    @transaction3 = create :transaction, { invoice_id: @invoice3.id, result: 'success' }
    @transaction4 = create :transaction, { invoice_id: @invoice4.id, result: 'success' }
    @transaction5 = create :transaction, { invoice_id: @invoice5.id, result: 'success' }
    @transaction6 = create :transaction, { invoice_id: @invoice6.id, result: 'failed' }

    @inv_item1 = create :invoice_item, { item_id: @item.id, invoice_id: @invoice1.id}
    @inv_item2 = create :invoice_item, { item_id: @item.id, invoice_id: @invoice2.id}
    @inv_item3 = create :invoice_item, { item_id: @item.id, invoice_id: @invoice3.id}
    @inv_item4 = create :invoice_item, { item_id: @item.id, invoice_id: @invoice4.id}
    @inv_item5 = create :invoice_item, { item_id: @item.id, invoice_id: @invoice5.id}
    @inv_item6 = create :invoice_item, { item_id: @item.id, invoice_id: @invoice6.id}

    visit merchant_discounts_path(@merchant)
  end

  it 'when I visit a merchants discount index page' do
    expect(current_path).to eq(merchant_discounts_path(@merchant))
  end

  it 'shows all bulk discounts, including percentage and quantity' do
    expect(page).to have_content(@merchant.name)
    expect(page).to have_content(@discount1.percentage)
    expect(page).to have_content(@discount1.quantity_threshold)
    expect(page).to have_content(@discount2.percentage)
    expect(page).to have_content(@discount2.quantity_threshold)
    expect(page).to have_content(@discount3.percentage)
    expect(page).to have_content(@discount3.quantity_threshold)
  end

  it 'can link to bulk discounts show page' do
    within("#discount-#{@discount1.id}") do
      click_link "Bulk Discount"
      expect(current_path).to eq(merchant_discount_path(@merchant, @discount1))
    end
  end

  it 'can link to create a new bulk discount' do
    click_link "Create New Discount"
    expect(current_path).to eq(new_merchant_discount_path(@merchant))
  end

  it 'can delete a bulk discount' do
    within("#discount-#{@discount2.id}") do
        expect(page).to have_content(@discount2.percentage)
        expect(page).to have_content(@discount2.quantity_threshold)
        click_link "Delete Discount"
        expect(current_path).to eq(merchant_discounts_path(@merchant))
      end
      expect(page).not_to have_content("Discount percentage: #{@discount2.percentage}%")
      expect(page).not_to have_content("Quantity Threshold: #{@discount2.quantity_threshold}")
  end
end






# As a merchant
# When I visit my bulk discounts index
# Then next to each bulk discount I see a link to delete it
# When I click this link
# Then I am redirected back to the bulk discounts index page
# And I no longer see the discount listed
# Merchant Bulk Discount Show
#

# Merchant Bulk Discounts Index
#
# As a merchant
# When I visit my merchant dashboard
# Then I see a link to view all my discounts
# When I click this link
# Then I am taken to my bulk discounts index page
# Where I see all of my bulk discounts including their
# percentage discount and quantity thresholds
# And each bulk discount listed includes a link to its show page
