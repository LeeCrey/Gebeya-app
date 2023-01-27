# frozen_string_literal: true

class CommmentController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_product_weigth_and_comment, only: %i[create]

  # GET products/:product_id/comments
  def index
    @comments = current_customer.comments.where(product_id: @product.id)
  end

  # POST products/:product_id/comments
  def create
    create_or_update_comment

    if current_customer.voted_for? @product && @weight == 0
      customer.unvote_for @product
    else
      @product.liked_by current_customer, vote_weight: @weight
    end

    head :created
  end

  private

  def create_or_update_comment
    comment = ProductComment.find_or_initialize(customer_id: current_customer.id, product_id: @product.id)
    comment.body = @comment
    comment.save
  end

  def set_product_weigth_and_comment
    @product = Product.find_by(id: params[:product_id])
    @weight = params[:weight].to_i
    @comment = params[:comment]
  end
end
