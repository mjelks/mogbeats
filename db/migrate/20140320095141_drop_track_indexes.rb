class DropTrackIndexes < ActiveRecord::Migration
  def up
    remove_index :tracks, :artist_mog_id
    remove_index :tracks, :album_mog_id
    add_index :tracks,  [:artist_mog_id, :album_mog_id, :track_mog_id], :unique => true
  end

  def down
    add_index :tracks, :artist_mog_id, :unique => true
    add_index :tracks, :album_mog_id, :unique => true
  end
end
