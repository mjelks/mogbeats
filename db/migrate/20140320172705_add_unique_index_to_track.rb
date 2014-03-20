class AddUniqueIndexToTrack < ActiveRecord::Migration
  def change
    add_index :tracks, [:track_mog_id, :album_id, :artist_id], :unique => true
  end
end
