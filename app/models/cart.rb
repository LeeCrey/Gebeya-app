# frozen_string_literal: true

class Cart < ApplicationRecord
  belongs_to :admin_user
  belongs_to :customer

  has_many :items, as: :itemable, dependent: :destroy_async
  has_many :products, through: :items
end
