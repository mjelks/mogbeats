class Album < ActiveRecord::Base
  has_many :albums_users
  has_many :users, :through => :albums_users, :class_name => "AlbumsUser", :foreign_key => :album_id, :source => :user

  # attr_accessible :title, :body
  attr_accessible :mog_id, :name

  def self.create_user_favorites(albums, user_id)
    # first generate albums into the album table if needed
    albums.each_with_index do |element, idx|
      album = self.find_or_create_by_mog_id_and_name(element['mog_album_id'], element['album_name'])
      # then associate with user
      AlbumsUser.create_sorted_entry(album.id, user_id, idx)
    end
  end

end
