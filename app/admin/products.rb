# frozen_string_literal: true

ActiveAdmin.register Product, namespace: "shops" do
  menu if: proc { !(current_admin_user.admin? || current_admin_user.super_admin?) }

  permit_params :locale, :name, :description, :origin, :price, :discount, :quantity, :shop_id, :category_id, images: []

  # includes([:comments])

  # Filters
  filter :name
  filter :origin
  filter :price
  filter :discount
  filter :quantity
  filter :category

  index do
    column :id
    column :category
    column :name
    column :origin
    column :price do |product|
      div class: "product-price" do
        number_to_currency(product.price, unit: "", delimiter: ",", separator: ",")
      end
    end
    column "Price Readable" do |product|
      div class: "product-price" do
        number_to_human(product.price)
      end
    end
    column :discount
    column :last_price do |product|
      div class: "product-price" do
        lprice = product.price - product.discount.to_d
        number_to_currency(lprice, unit: "", delimiter: ",", separator: ",")
      end
    end

    column :quantity do |product|
      number_with_delimiter(product.quantity, delimiter: ",")
    end
    column :product_comments
    actions
  end

  # Form
  form do |f|
    inputs "Product" do
      input :category
      input :name
      input :origin
      input :price
      input :discount
      input :quantity
      input :description
      input :images, as: :file, input_html: { multiple: true }
    end
    para "Press cancel to return to the list without saving."
    actions
  end

  ## show page
  show do
    attributes_table do
      row :name
      row :category
      row :price
      row :origin
      row :quantity
      row :description
      row :discount
      row :images do |product|
        div class: "slideshow-container" do
          if product.images.attached?
            product.images_attachments.each do |img|
              div class: "product-image mySlides fade" do
                image_tag img
              end
            end
          end
          a "❯", class: "right", id: "show_more"
          a "❮", class: "left", id: "back_one"
        end
      end
    end
  end

  # Controller
  controller do
    rescue_from ActiveRecord::RecordNotFound, with: -> { redirect_to shops_products_path }

    def show
      @product = Product.includes(:category, images_attachments: :blob).where(id: params[:id]).references(:category, images_attachments: :blob)&.first
    end

    def create
      @product = current_admin_user.products.new(permitted_params[:product])
      if @product.save
        redirect_to shops_product_url(@product)
      else
        render :new
      end
    end

    private

    def scoped_collection
      end_of_association_chain.includes([:category]).where(admin_user_id: current_admin_user.id)
    end
  end
end
