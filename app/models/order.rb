class Order < ApplicationRecord
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { awaiting_payment: 0, confirmation_payment: 1, production_now: 2, preparing_now: 3,shipped: 4 }
  has_many :order_items, dependent: :destroy
  belongs_to :customer
  validates :status, presence: true
end
