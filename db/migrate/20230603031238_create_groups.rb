class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.string :name
      t.text :introduction
      t.integer :owner_

      t.timestamps
    end
  end
end
