require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to(:item) }
    it { should belong_to(:invoice) }
    it { should have_many(:merchants).through(:item) }
    it { should have_many(:discounts).through(:merchants) }

  end

  describe 'validations' do
    it { should validate_presence_of(:item_id) }
    it { should validate_presence_of(:invoice_id) }
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:status) }
  end

  describe 'model methods' do
    WebMock.allow_net_connect!
    before do
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
      @invoice5 = create :invoice, { customer_id: @customer5.id, status: 'cancelled' }
      @invoice6 = create :invoice, { customer_id: @customer6.id, status: 'completed' }

      @transaction1 = create :transaction, { invoice_id: @invoice1.id, result: 'success' }
      @transaction2 = create :transaction, { invoice_id: @invoice2.id, result: 'success' }
      @transaction3 = create :transaction, { invoice_id: @invoice3.id, result: 'success' }
      @transaction4 = create :transaction, { invoice_id: @invoice4.id, result: 'success' }
      @transaction5 = create :transaction, { invoice_id: @invoice5.id, result: 'success' }
      @transaction6 = create :transaction, { invoice_id: @invoice6.id, result: 'failed' }

      @inv_item1 = create :invoice_item, { item_id: @item.id, invoice_id: @invoice1.id, status: "pending"}
      @inv_item2 = create :invoice_item, { item_id: @item.id, invoice_id: @invoice2.id, status: "pending"}
      @inv_item3 = create :invoice_item, { item_id: @item.id, invoice_id: @invoice3.id, status: "pending"}
      @inv_item4 = create :invoice_item, { item_id: @item.id, invoice_id: @invoice4.id, status: "packaged"}
      @inv_item5 = create :invoice_item, { item_id: @item.id, invoice_id: @invoice5.id, status: "packaged"}
      @inv_item6 = create :invoice_item, { item_id: @item.id, invoice_id: @invoice6.id, status: "shipped"}
    end

    it 'returns incomplete invoices' do
      expect(InvoiceItem.incomplete_inv).to eq([@inv_item1, @inv_item2, @inv_item3, @inv_item4, @inv_item5])
    end

    it 'can return the best discount' do
      expect(@inv_item1.best_discount).to eq(@discount2)
    end

    xit 'can calculate a total for invoice item' do
      expect(@inv_item1.invoice_item_total).to eq(@inv_item1.quantity * @inv_item1.unit_price)
    end

    xit 'can caluate invoice item total with the discount' do
      expect(@inv_item1.invoice_item_total_with_discount).to eq(2843499)
    end

  end
end
