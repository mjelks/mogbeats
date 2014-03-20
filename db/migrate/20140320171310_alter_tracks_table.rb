class AlterTracksTable < ActiveRecord::Migration
  def up
    remove_index :tracks,  [:artist_mog_id, :album_mog_id, :track_mog_id]
    remove_column :tracks, :image_url
    remove_column :tracks, :artist_name
    remove_column :tracks, :album_name
    remove_column :tracks, :artist_mog_id
    remove_column :tracks, :album_mog_id
    change_table :tracks do |t|
      t.references :album
      t.references :artist
    end
  end

  def down
    add_index :tracks,  [:artist_mog_id, :album_mog_id, :track_mog_id], :unique => true
    add_column :tracks, :artist_mog_id, :integer
    add_column :tracks, :album_mog_id, :integer
    add_column :tracks, :image_url, :string
    add_column :tracks, :artist_name, :string
    add_column :tracks, :album_name, :string
  end
end
