class Playlist < ActiveRecord::Base
  belongs_to :user

  has_many :playlists_tracks
  has_many :tracks, :through => :playlists_tracks

  attr_accessible :mog_id, :user_id, :name, :image_url, :is_public, :plays

end
