class CreateRates < ActiveRecord::Migration[5.2]
  def change
    create_table :rates do |t|
      t.integer :rate
      t.text :comment
      t.integer :product_id
      t.integer :user_id
      t.boolean :is_deleted

      t.timestamps
    end
  end
end
