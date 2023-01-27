# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :admin_user

  has_many :items, as: :itemable, dependent: :destroy_async
  has_many :products, through: :items
end
