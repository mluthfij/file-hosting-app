class AddFolderIdToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :folder_id, :integer, null: true
  end
end
