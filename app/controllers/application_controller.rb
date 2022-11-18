class ApplicationController < ActionController::Base
  def total
    @total = current_customer.cart_items.inject(0) { |sum, item| sum + item.subtotal }
  end
end
