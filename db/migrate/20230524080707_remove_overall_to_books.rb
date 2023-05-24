class RemoveOverallToBooks < ActiveRecord::Migration[6.1]
  def change
    remove_column :books, :overall, :integer
  end
end
