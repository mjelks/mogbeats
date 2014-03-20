class AlbumsUser < ActiveRecord::Base
  belongs_to :album
  belongs_to :user

  attr_accessible :album_id, :user_id, :sort_value

  self.primary_keys = :album_id, :user_id

  def self.create_sorted_entry(album_id, user_id, order_id)
    au = AlbumsUser.find_or_create_by_album_id_and_user_id(album_id, user_id)
    au.update_attributes(:sort_value => order_id)
  end

end
