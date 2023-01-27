# frozen_string_literal: true

ActiveAdmin.register ProductComment, namespace: "shops" do
  config.filters = false
  menu if: proc { !(current_admin_user.admin? || current_admin_user.super_admin?) }

  actions :all, except: %i[new delete]

  includes(:product)

  index do
    column :content
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
        if product.images.attached?
          image_tag product.images.attachments.first
        end
      end
    end
  end

  # Controller
  controller do
    rescue_from ActiveRecord::RecordNotFound, with: -> { redirect_to shops_products_path }

    def create
      @product = current_admin_user.products.new(permitted_params[:product])
      if @product.save
        redirect_to shops_product_url(@product)
      else
        render :new
      end
    end

    private

    # def scoped_collection
    # end_of_association_chain.includes(:category).where(admin_user_id: current_admin_user.id)
    # end
  end
end
