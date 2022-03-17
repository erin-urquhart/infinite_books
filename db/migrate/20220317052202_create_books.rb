class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :name
      t.string :author
      t.string :description
      t.integer :publication_year
      t.string :publisher
      t.integer :isbn
      t.integer :price_cents

      t.timestamps
    end
  end
end
