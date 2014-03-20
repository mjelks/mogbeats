class Track < ActiveRecord::Base
  # attr_accessible :title, :body
  has_and_belongs_to_many :playlists

  has_many :tracks_users
  has_many :users, :through => :tracks_users
end
