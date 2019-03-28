class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.integer :status
      t.integer :user_id
      t.boolean :is_deleted

      t.timestamps
    end
  end
end
