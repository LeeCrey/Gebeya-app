# frozen_string_literal: true

class CartsController < ApplicationController
  protect_from_forgery with: :null_session
  respond_to :json

  before_action :authenticate_customer!

  # GET  /cart
  def index
    @carts = current_customer.carts.includes(:admin_user).references(:admin_user)

    if stale? @carts
      expires_in 1.day

      render json: { carts: ActiveModelSerializers::SerializableResource.new(@carts, each_serializer: CartSerializer) }
    end
  end

  # GET /carts/:id
  # CHECKOUT
  def show
  end

  # DELETE /cart/:id
  def destroy
    Cart.destroy_by(id: params[:id])

    head :no_content
  end

  # DELETE /cart
  def clear
    Cart.includes(:cart_items).destroy_all

    head :no_content
  end
end
