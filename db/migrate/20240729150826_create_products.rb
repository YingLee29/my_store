# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :product_name,         null: false
      t.integer :category,            null: false, default: 1
      t.decimal :price,               null: false, default: 0.0
      t.decimal :old_price,           null: false, default: 0.0
      t.integer :stock_status,        null: false, default: 0
      t.integer :new_status, default: 0
      t.string :screen_size
      t.string :refresh_rate
      t.integer :ram, null: false, default: 2
      t.integer :storage
      t.boolean :installment,         null: false, default: true
      t.integer :brand,               null: false
      t.timestamps
    end

    add_index :products, :product_name, unique: true
  end
end
