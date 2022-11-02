class OrderItem < ApplicationRecord
  enum making_status: { can_not_production: 0, awaiting_production: 1, production_now: 2, production_end: 3 }
  belongs_to :item
  belongs_to :order
end
