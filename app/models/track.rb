class Track < ActiveRecord::Base
  include ApplicationHelper

  has_many :tracks_users
  has_many :users, :through => :tracks_users

  has_and_belongs_to_many :playlists

  # attr_accessible :title, :body
end
