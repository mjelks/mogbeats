class CreatePlaylistsTracksTable < ActiveRecord::Migration
  def up
    create_table :playlists_tracks, :id => false do |t|
      t.references :playlist
      t.references :track
      t.integer :sort_value
    end
    add_index :playlists_tracks, [:playlist_id, :track_id]
  end

  def down
    drop_table :playlists_tracks
  end
end
