class CreatePlaylists < ActiveRecord::Migration
  def up
    create_table :playlists do |t|
      t.references :user

      t.string :name
      t.string :link

      t.timestamps
    end
  end

  def down
    drop table :playlists
  end
end
