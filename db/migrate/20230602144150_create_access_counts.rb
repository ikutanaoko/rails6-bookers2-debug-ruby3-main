class CreateAccessCounts < ActiveRecord::Migration[6.1]
  def change
    create_table :access_counts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
