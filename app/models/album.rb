class Album < ActiveRecord::Base
  include MogBeats::Formatter

  has_many :albums_users
  has_many :users, :through => :albums_users

  has_many :tracks

  # attr_accessible :title, :body
  attr_accessible :mog_id, :name, :image_url

  def self.create_user_favorites(albums, user_id)
    # first generate albums into the album table if needed
    albums.each_with_index do |element, idx|
      album = self.create_album(element['mog_album_id'], element['album_name'], element['image_url'])
      # then associate with user
      AlbumsUser.create_sorted_entry(album.id, user_id, idx)
    end
  end

  def self.create_album(mog_id, album_name, image_url="")
    album = self.find_or_create_by_mog_id_and_name(MogBeats::Formatter.mog_id_cleanup(mog_id).to_i, album_name)
    album.update_attributes(:image_url => MogBeats::Formatter.mog_image_cleanup(image_url)) unless image_url.blank?
    return album
  end

end
