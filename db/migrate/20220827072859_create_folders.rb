class CreateFolders < ActiveRecord::Migration[6.1]
  def change
    create_table :folders do |t|
      t.string :name
      t.references :repo, null: false, foreign_key: true

      t.timestamps
    end
  end
end
