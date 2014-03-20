class ArtistsUser < ActiveRecord::Base
  belongs_to :artist
  belongs_to :user

  attr_accessible :album_id, :user_id, :sort_value

  self.primary_keys = :album_id, :user_id


end