class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.integer :mog_id
      t.string :name

      t.timestamps
    end
  end
end
