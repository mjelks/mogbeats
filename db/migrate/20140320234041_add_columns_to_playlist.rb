class AddColumnsToPlaylist < ActiveRecord::Migration
  def change
    remove_column :playlists, :link

    add_column :playlists, :mog_id, :integer
    add_column :playlists, :image_url, :string
    add_column :playlists, :is_public, :boolean
    add_column :playlists, :plays, :integer

    add_column :users, :mog_screen_name, :string
    add_column :users, :mog_user_id, :integer
  end
end
