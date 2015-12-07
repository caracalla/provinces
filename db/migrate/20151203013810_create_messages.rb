class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :body, null: false
      t.integer :money, default: 0
      t.references :user, null: false, index: true, foreign_key: true

      t.integer :messageable_id, null: false, index: true
      t.string :messageable_type, null: false

      t.timestamps null: false
    end
  end
end
