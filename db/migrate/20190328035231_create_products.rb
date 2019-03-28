class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :category_id
      t.string :information
      t.integer :price
      t.string :image_path
      t.integer :quantity
      t.boolean :is_deleted

      t.timestamps
    end
  end
end
