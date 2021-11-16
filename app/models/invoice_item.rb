class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  has_many :merchants, through: :item
  has_many :discounts, through: :merchants

  validates_presence_of :item_id
  validates_presence_of :invoice_id
  validates_presence_of :quantity
  validates_presence_of :unit_price
  validates_presence_of :status

  def self.incomplete_inv
    self.where(status: ['pending', 'packaged'])
  end

  def best_discount
      discounts.joins(:items)
              .order(percentage: :desc)
              .where('quantity_threshold <= ?', "#{self.quantity}")
              .first
  end

  def invoice_item_total
    (quantity * unit_price)
  end

  def invoice_item_total_with_discount
    invoice_item_total - (invoice_item_total * (best_discount.percentage.to_f / 100))
  end

end
