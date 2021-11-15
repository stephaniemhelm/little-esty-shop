require 'rails_helper'

RSpec.describe Discount, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:items).through(:merchant) }
    it { should have_many(:invoices).through(:merchant) }
    it { should have_many(:invoice_items).through(:invoices) }

  end

  it 'can find name of merchant associated with discount' do
    @merchant = create(:merchant)
    @discount1 = Discount.create!(percentage: 20, quantity_threshold: 10, merchant_id: @merchant.id)
    expect(@discount1.merchant_name).to eq(@merchant.name)
  end
end
