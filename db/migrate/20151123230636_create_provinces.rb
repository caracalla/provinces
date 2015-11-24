class CreateProvinces < ActiveRecord::Migration
  def change
    create_table :provinces do |t|
      t.string :name, null: false, unique: true
      t.string :user_title, null: false
      t.string :currency_name, null: false
      t.string :government_type, null: false
      t.string :resource_1, null: false
      t.string :resource_2, null: false
      t.text :description

      t.integer :population, null: false, default: 0
      t.integer :money, null: false, default: 0
      t.integer :infrastructure, null: false, default: 0
      t.integer :technology, null: false, default: 0
      t.integer :local_tax_rate, null: false, default: 15

      t.references :user, null: false, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
