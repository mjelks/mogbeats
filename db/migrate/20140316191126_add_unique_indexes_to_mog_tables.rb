class AddUniqueIndexesToMogTables < ActiveRecord::Migration
  def change
    add_index :albums, :mog_id, :unique => true
    add_index :artists, :mog_id, :unique => true
    add_index :tracks, :artist_mog_id, :unique => true
    add_index :tracks, :album_mog_id, :unique => true
  end
end
