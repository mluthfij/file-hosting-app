class AddParentToFolders < ActiveRecord::Migration[6.1]
  def change
    add_column :folders, :parent_id, :integer, null: true
  end
end
