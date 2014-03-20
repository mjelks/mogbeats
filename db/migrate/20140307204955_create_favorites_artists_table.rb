class CreateFavoritesArtistsTable < ActiveRecord::Migration
  def up
    create_table :artists_users, :id => false do |t|
      t.references :artist
      t.references :user
      t.integer :sort_value
    end
    add_index :artists_users, [:artist_id, :user_id]
  end

  def down
    drop_table :artists_users
  end
end
