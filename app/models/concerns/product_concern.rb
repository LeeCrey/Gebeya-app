# frozen_string_literal: true

module ProductConcern
  extend ActiveSupport::Concern

  included do
    DISCOUNT_ERROR_MSG = %Q(It's recommended to leave discount blank if you don't want to set)

    # Validations
    validates :name, :price, :quantity, presence: true
    validates :name, length: { within: 2..50 }
    validates :price, comparison: { greater_than: 0.0 }
    validates :quantity, comparison: { greater_than: -1, message: "Must be positive" }
    validates :discount, comparison: {
                           greater_than: 0.0,
                           message: DISCOUNT_ERROR_MSG,
                         }, if: -> { discount.present? }
    validates :price, with: :price_should_be_greater_than_discount
    validates :images, attached: true,
                       processable_image: true,
                       content_type: %i[png jpg jpeg],
                       size: { less_than: 1.megabytes, message: "is too large" }

    # SCOPES
    scope :list_get, ->(ids) do
            with_attached_images.where.not(id: ids).references(:images_attachments).limit(8)
          end
    scope :with_category, ->(category) do
            joins(:category).where(category: { name: category.capitalize }).limit(8)
          end
    scope :recent, ->(limit) do
            all.order(id: :asc).limit(limit)
          end

    scope :get_list_but_exclude, ->(ids) do
            with_attached_images.where.not(id: ids).references(:images_attachments).limit(8)
          end
  end

  private

  def price_should_be_greater_than_discount
    if discount.present? and (price <= discount)
      errors.add(:discount, "Discount can not be greater than or equal to price.")
    end
  end
end
