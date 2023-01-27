# frozen_string_literal: true

class OrdersController < ApplicationController
  # protect_from_forgery with: :null_session
  # respond_to :json

  before_action :authenticate_customer!
  before_action :set_cart

  # POST /carts/:cart_id/order
  def create
    @order = current_customer.orders.new(admin_user_id: @cart.admin_user_id)
    if @order.save
      @cart_items_ids = @cart.cart_items.ids
    end
  end

  private

  def set_cart
    @cart = Car.find(params[:cart_id])
  end
end
