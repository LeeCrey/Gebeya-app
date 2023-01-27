# frozen_string_literal: true

class ProductComment < ApplicationRecord
  belongs_to :customer
  belongs_to :product

  # Validations
  validates :content, presence: true
end
