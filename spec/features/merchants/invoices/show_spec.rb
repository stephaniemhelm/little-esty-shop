require 'rails_helper'

RSpec.describe 'merchant invoice show page' do
  before do
    @merchant = create(:merchant)
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)

    @discount1 = Discount.create!(percentage: 20, quantity_threshold: 10, merchant_id: @merchant.id)
    @discount2 = Discount.create!(percentage: 30, quantity_threshold: 15, merchant_id: @merchant.id)
    @discount3 = Discount.create!(percentage: 15, quantity_threshold: 5, merchant_id: @merchant.id)

    @item = create :item, { merchant_id: @merchant1.id }
    @item1 = create :item, { merchant_id: @merchant1.id }
    @item2 = create :item, { merchant_id: @merchant1.id }
    @item3 = create :item, { merchant_id: @merchant2.id }

    @customer = create :customer

    @invoice = create :invoice, { customer_id: @customer.id }
    @invoice1 = create :invoice, { customer_id: @customer.id }

    @transaction = create :transaction, { invoice_id: @invoice.id, result: 'success' }


    @inv_item1 = create :invoice_item, { item_id: @item1.id, invoice_id: @invoice.id, status: 'pending' }
    @inv_item2 = create :invoice_item, { item_id: @item2.id, invoice_id: @invoice.id}
    @inv_item3 = create :invoice_item, { item_id: @item3.id, invoice_id: @invoice.id}
    @inv_item4 = create :invoice_item, { item_id: @item.id, quantity: 15, unit_price: 200, invoice_id: @invoice1.id, status: "pending"}

    visit merchant_invoice_path(@merchant1, @invoice)
  end

  it 'when i visit merchant invoice show page' do
    expect(current_path).to eq(merchant_invoice_path(@merchant1, @invoice))
  end

  it 'i see invoice id, status, created_at formatted, and customer first and last' do
    expect(page).to have_content(@invoice.id)
    expect(page).to have_content(@invoice.status)
    expect(page).to have_content(@invoice.created_at.strftime("%A, %B %d, %Y"))
    expect(page).to have_content(@invoice.customer.full_name)
  end

  it 'i see all the items on the invoice with name, quantity, sell price and inv_item status only for this merchant' do
    expect(page).to have_content(@item1.name)
    expect(page).to have_content(@item1.invoice_items.first.quantity)
    expect(page).to have_content(@item1.invoice_items.first.unit_price.fdiv(100))
    expect(page).to have_content(@item1.invoice_items.first.status)
    expect(page).to have_content(@item2.name)
  end

  it 'i see total revenue for all of my items on invoice' do
    expect(page).to have_content("Total Merchant Revenue for this Invoice")
  end

  it 'can show total invoice revenue' do
    expect(@invoice1.total_invoice_revenue(@invoice1.id)).to eq(3000)
  end

  it 'can show total invoice revenue' do
    expect(@invoice1.total_invoice_revenue_with_bulk_discounts).to eq(3000)
  end
end
