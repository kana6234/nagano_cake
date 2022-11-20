class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    if admin_signed_in?
      admin_top_path
    else
      root_path
    end
  end
  def total
    @total = current_customer.cart_items.inject(0) { |sum, item| sum + item.subtotal }
  end
end
