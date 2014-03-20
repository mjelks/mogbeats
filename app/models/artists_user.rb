class ArtistsUser < ActiveRecord::Base
  belongs_to :artist
  belongs_to :user

  attr_accessible :artist_id, :user_id, :sort_value

  self.primary_keys = :artist_id, :user_id

  def self.create_sorted_entry(artist_id, user_id, order_id)
    au = ArtistsUser.find_or_create_by_artist_id_and_user_id(artist_id, user_id)
    au.update_attributes(:sort_value => order_id)
  end

end