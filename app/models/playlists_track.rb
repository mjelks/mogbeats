class PlaylistsTrack < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :track

  attr_accessible :playlist_id, :track_id, :sort_value

  self.primary_keys = :playlist_id, :track_id

  def self.create_sorted_entry(playlist_id, track_id, order_id)
    self.where(:playlist_id => playlist_id, :track_id => track_id, :sort_value => order_id).first_or_create()
  end
end
