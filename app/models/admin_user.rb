# frozen_string_literal: true

class AdminUser < ApplicationRecord
  # :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :registerable

  # R/N
  has_many :products, dependent: :destroy_async
  has_many :carts, dependent: :destroy_async
  has_many :orders

  # Validations
  validates :shop_name, presence: true, if: -> { shop? }

  # SCOPES
  scope :recent_shops, ->(limit) do
          where(admin: false).order(id: :desc).limit(limit)
        end

  def name
    return shop_name if shop?

    email
  end

  def shop?
    !(admin? || super_admin?)
  end
end
