class AddImageToAlbumsAndTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :image_url, :string
    add_column :albums, :image_url, :string
  end
end
