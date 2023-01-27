# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :itemable, polymorphic: true
  belongs_to :product
  belongs_to :customer

  # Validations
  validates :product_id, uniqueness: { scope: %i[itemable_id customer_id], message: I18n.t("cart.exist")}
end
