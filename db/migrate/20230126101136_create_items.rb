class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.references :itemable, polymorphic: true, null: false
      t.belongs_to :product, null: false, foreign_key: true
      t.belongs_to :customer, null: false, foreign_key: true

      t.timestamps
    end

    add_index :items, %i[product_id customer_id], unique: true
  end
end
