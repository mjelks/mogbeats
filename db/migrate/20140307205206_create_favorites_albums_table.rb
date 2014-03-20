class CreateFavoritesAlbumsTable < ActiveRecord::Migration
  def up
    create_table :albums_users, :id => false do |t|
      t.references :album
      t.references :user
      t.integer :sort_value
    end
    add_index :albums_users, [:album_id, :user_id]
  end

  def down
    drop_table :albums_users
  end
end
