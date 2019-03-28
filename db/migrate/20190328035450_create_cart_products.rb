class CreateCartProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_products do |t|
      t.integer :product_id
      t.integer :quantity
      t.integer :price
      t.boolean :is_deleted

      t.timestamps
    end
  end
end
