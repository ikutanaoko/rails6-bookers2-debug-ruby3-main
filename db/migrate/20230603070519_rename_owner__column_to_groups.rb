class RenameOwnerColumnToGroups < ActiveRecord::Migration[6.1]
  def change
    rename_column :groups, :owner_, :owner_id
  end
end
