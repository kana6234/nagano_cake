class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def with_tax_price
    (price * 1.1).floor
  end

  def subtotal
    item.with_tax_price * amount
  end
end
