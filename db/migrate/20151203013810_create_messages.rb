class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :body, null: false
      t.integer :money, default: 0
      t.references :sender, null: false, index: true
      t.references :messageable, null: false, polymorphic: true, index: true
      t.integer :parent_message_id, index: true, foreign_key: true
      t.boolean :read, null: false, default: false

      t.timestamps null: false
    end
  end
end
