class CartItemSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :product, :item_image

  def product
    object.product.slice(:name, :price, :discount)
  end

  def item_image
    Rails.application.routes.url_helpers.rails_blob_url(object.product.images&.first)
  end
end
