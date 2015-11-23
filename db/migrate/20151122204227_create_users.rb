class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, null: false, unique: true, index: true
      t.string :password_digest, null: false
      t.string :session_token, null: false, unique: true, index: true
      t.string :provincial_title
      t.string :national_title
      t.boolean :admin, null: false, default: false

      t.timestamps null: false
    end
  end
end
