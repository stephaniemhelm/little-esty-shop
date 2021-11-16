require 'rails_helper'

RSpec.describe "admin invoice show" do
  before do
    @merchant = create(:merchant)

    @discount1 = Discount.create!(percentage: 20, quantity_threshold: 10, merchant_id: @merchant.id)
    @discount2 = Discount.create!(percentage: 30, quantity_threshold: 15, merchant_id: @merchant.id)
    @discount3 = Discount.create!(percentage: 15, quantity_threshold: 5, merchant_id: @merchant.id)

    @customer3 = create :customer

    @item7 = create :item, { merchant_id: @merchant.id }
    @item8 = create :item, { merchant_id: @merchant.id }

    @invoice8 = create :invoice, { customer_id: @customer3.id, created_at: DateTime.new(2021, 1, 5) }

    @inv_item11 = create :invoice_item, { item_id: @item7.id, invoice_id: @invoice8.id, unit_price: 10000, quantity: 4, status: "pending" }
    @inv_item12 = create :invoice_item, { item_id: @item8.id, invoice_id: @invoice8.id, unit_price: 3000, quantity: 6, status: "shipped"}

    visit admin_invoice_path(@invoice8.id)
  end

  it 'shows invoice info' do
    expect(page).to have_content(@invoice8.id)
    expect(page).to have_content(@invoice8.status)
    expect(page).to have_content(@invoice8.created_at.strftime('%A, %B%e, %Y'))
    expect(page).to have_content(@invoice8.customer.full_name)
  end

  it 'shows invoice item info' do
    expect(page).to have_content(@item7.name)
    expect(page).to have_content(@item8.name)

    within("#item-#{@item7.id}") do
      expect(page).to have_content(@item7.name)
      expect(page).to have_content(@inv_item11.quantity)
      expect(page).to have_content(@inv_item11.unit_price / 100)
      expect(page).to have_content(@inv_item11.status)
      expect(page).to_not have_content(@inv_item12.quantity)
    end
  end

  it 'gives dropdown menu option for invoice item status' do
    within("#item-#{@item7.id}") do
      expect(find_field(:invoice_item_status).value).to eq("pending")

      expect(page).to have_button("Update Invoice Status")
      select "shipped", from: 'invoice_item_status'
      click_button "Update Invoice Status"

      expect(current_path).to eq(admin_invoice_path(@invoice8.id))

      expect(find_field(:invoice_item_status).value).to eq("shipped")
    end
  end

  it 'shows total revenue for an invoice' do
    expect(@invoice8.total_invoice_revenue(@invoice8.id)).to eq(58000)
  end

  it 'shows total discounted revenue for this invoice' do
    expect(@invoice8.total_invoice_revenue_with_bulk_discounts).to eq(55300)

  end
end
