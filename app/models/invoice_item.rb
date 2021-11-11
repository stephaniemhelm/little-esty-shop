class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  validates_presence_of :item_id
  validates_presence_of :invoice_id
  validates_presence_of :quantity
  validates_presence_of :unit_price
  validates_presence_of :status

  def self.incomplete_inv
    self.where(status: ['pending', 'packaged'])
  end

end
