class CreateItemOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :item_orders do |t|
      t.decimal :price
      t.integer :quantity

      t.timestamps
    end
  end
end
