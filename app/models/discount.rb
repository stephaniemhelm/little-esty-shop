class Discount < ApplicationRecord
  belongs_to :merchant
  has_many :items, through: :merchant
  has_many :invoices, through: :merchant
  has_many :invoice_items, through: :invoices

  def merchant_name
    merchant.name
  end
end
