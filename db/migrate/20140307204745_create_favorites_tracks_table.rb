class CreateFavoritesTracksTable < ActiveRecord::Migration
  def up
    create_table :tracks_users, :id => false do |t|
      t.references :track
      t.references :user
      t.integer :sort_value
    end
    add_index :tracks_users, [:track_id, :user_id]
  end

  def down
    drop_table :tracks_users
  end
end
