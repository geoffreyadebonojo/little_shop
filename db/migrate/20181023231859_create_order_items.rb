class CreateOrderItems < ActiveRecord::Migration[5.1]
  def change
    create_table :order_items do |t|
      t.references :order, foreign_key: true
      t.references :item, foreign_key: true
      t.integer :item_quantity
      t.integer :item_price
      t.boolean :fulfilled?, default: false, null: false

      t.timestamps
    end
  end
end
