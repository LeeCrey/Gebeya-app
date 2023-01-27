# frozen_string_literal: true

class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :origin, :quantity, :rates, :photos, :price, :discount

  def rates
    3.5
  end

  def photos
    object.images_attachments.map { |x| Rails.application.routes.url_helpers.rails_blob_url(x) }
  end
end
