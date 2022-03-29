class UpdateOrderColumns < ActiveRecord::Migration[7.0]
  def change
    remove_column :orders, :name, :string
    remove_column :orders, :email, :string
    remove_column :orders, :address, :text
    add_column :orders, :subtotal, :decimal
    add_column :orders, :taxes, :decimal
    add_column :orders, :total, :decimal
    add_column :orders, :payment_id, :string
  end
end
