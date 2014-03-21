class AlterArtistAlbumUniqueIndexes < ActiveRecord::Migration
  def up
    remove_index :artists, :mog_id
    remove_index :albums, :mog_id
    add_index :artists, [:mog_id, :name], :unique => true
    add_index :albums, [:mog_id, :name], :unique => true
  end

  def down
  end
end
