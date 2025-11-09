class CreateAssetPrices < ActiveRecord::Migration[7.2]
  def change
    create_table :asset_prices do |t|
      t.date :price_date, null: false
      t.string :asset_type, null: false
      t.decimal :price, precision: 8, scale: 2, null: false
      t.string :unit, null: false

      t.timestamps
    end

    add_index :asset_prices, [:price_date, :asset_type], unique: true
  end
end
