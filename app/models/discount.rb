class Discount < ApplicationRecord
  belongs_to :merchant

  def merchant_name
    merchant.name
  end
end
