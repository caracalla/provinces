class AddFlagsToNations < ActiveRecord::Migration
  def up
    add_attachment :nations, :flag
  end

  def down
    remove_attachment :nations, :flag
  end
end
