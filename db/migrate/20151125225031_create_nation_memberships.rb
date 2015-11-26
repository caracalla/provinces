class CreateNationMemberships < ActiveRecord::Migration
  def change
    create_table :nation_memberships do |t|
      t.integer :rank, null: false, default: 0
      t.string :member_title, null: false, default: "Member"
      t.string :state, null: false, default: "inactive"

      t.references :province, null: false, index: true, foreign_key: true
      t.references :nation, null: false, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
