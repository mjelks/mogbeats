class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :name

      t.integer :track_mog_id
      t.integer :artist_mog_id
      t.integer :album_mog_id

      t.timestamps
    end
  end
end
