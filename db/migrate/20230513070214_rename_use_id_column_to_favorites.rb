class RenameUseIdColumnToFavorites < ActiveRecord::Migration[6.1]
  def change
    rename_column :favorites, :use_id, :user_id
  end
end
