class AddUniqueIndexesToLookupTables < ActiveRecord::Migration
  def change
    remove_index :albums_users, [:album_id, :user_id]
    remove_index :artists_users, [:artist_id, :user_id]
    remove_index :tracks_users, [:track_id, :user_id]


    add_index :albums_users, [:album_id, :user_id], :unique => true
    add_index :artists_users, [:artist_id, :user_id], :unique => true
    add_index :tracks_users, [:track_id, :user_id], :unique => true
  end
end
