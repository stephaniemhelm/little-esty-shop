class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :discounts
  validates_presence_of :name
  validates_presence_of :status

  #class method on transactions where transactions.result = success (merge?)

  def favorite_customers
    customers.joins(invoices: :transactions)
             .where('transactions.result = ?', 'success')
             .group('customers.id')
             .select('customers.*')
             .order(count: :desc)
             .limit(5)
             .count
  end

  def top_five_items
    items.joins(invoices: :transactions)
         .where("transactions.result = 'success'")
         .select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
         .group(:id)
         .order('revenue desc')
         .limit(5)
  end

  def self.merchant_status(status)
    where(status: status)
  end

  def self.top_five_merchants
    self.joins(:items, invoices: :transactions)
       .where("transactions.result = 'success'")
       .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
       .group(:id)
       .order('revenue desc')
       .limit(5)
  end

  def merchant_best_day
    items.joins(invoices: :transactions)
    .where("transactions.result = 'success'")
    .select('invoices.created_at, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
    .group('invoices.created_at')
    .order('revenue desc')
    .first
    .created_at
    .to_date
  end

  def merchant_discounts
    discounts
  end
end
