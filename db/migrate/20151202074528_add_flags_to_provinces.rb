class AddFlagsToProvinces < ActiveRecord::Migration
  def up
    add_attachment :provinces, :flag
  end

  def down
    remove_attachment :provinces, :flag
  end
end
