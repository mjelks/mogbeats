class AddOneMoreColToPlaylists < ActiveRecord::Migration
  def change
    add_column :playlists, :screen_name, :string
  end
end
