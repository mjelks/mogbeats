class AddAlbumNameToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :album_name, :string
  end
end
