class AddRankToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :required_rank, :integer
  end
end
