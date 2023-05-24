class AddOverallToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :overall, :integer
  end
end
