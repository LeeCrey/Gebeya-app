# frozen_string_literal: true

class ProductsController < ApplicationController
  protect_from_forgery with: :null_session
  respond_to :json

  # append_before_action :recommend, :trending, only: %i[index]
  before_action :set_exclude_ids, only: %i[index show]
  append_before_action :list_of_products, only: %i[index]

  # GET /products or /products.json
  def index
    if stale?(@products)
      expires_in 4.minutes

      render json: {
        products: ActiveModelSerializers::SerializableResource.new(@products, each_serializer: ProductSerializer),
        trending: [],
      }
    end
  end

  # GET /products/1 or /products/1.json
  def show
    @product = Product.with_attached_images.where(id: params[:id]).references(:images_attachments).first
    @related = Product.with_attached_images.where(category_id: @product.category_id)
      .references(:images_attachments)
      .where.not(id: @exclude_ids)
      .order(updated_at: :desc).limit(6)

    lst = @related.last

    if lst
      render_show if stale? [@product, lst]
    else
      render_show if stale? [@product]
    end
  end

  # GET /categories
  def categories
    @categories = Category.order(name: :asc)

    if stale?(@categories)
      expires_in 10.days

      render json: @categories
    end
  end

  private

  def set_exclude_ids
    if customer_signed_in?
      @exclude_ids = current_customer.items.pluck(:product_id)
    else
      @exclude_ids = []
    end
  end

  def render_show
    expires_in 1.month

    render json: {
      product: ActiveModelSerializers::SerializableResource.new(@product, each_serializer: ProductSerializer),
      related_products: ActiveModelSerializers::SerializableResource.new(@related, each_serializer: ProductSerializer),
    }
  end

  # GET /recommend
  def recommend
    if customer_signed_in?
      # based on search history
      for_signed_in_customer
    else
      for_guest
    end
  end

  # 5 products are enough
  def trending
    @trending = []
  end

  # list of products
  def list_of_products
    cat = params[:category]

    # if signed in
    @products = Product.get_list_but_exclude(@exclude_ids).to_a
    @products.delete_at(-1) if @products.size.odd?

    # if category.downcase == "all"
    #   @products = Product.list_get([])
    # else
    #   @products = Product.with_category(category)
    # end
  end

  # for authorized
  def for_signed_in_customer
    @recommended = Product.all.limit(6)
  end

  # for un authorized request
  def for_guest
    @recommended = Product.where.not(id: @products.ids).limit(6)
  end
end
