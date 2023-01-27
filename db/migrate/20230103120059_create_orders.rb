class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.belongs_to :customer, null: false, foreign_key: true
      t.belongs_to :admin_user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
