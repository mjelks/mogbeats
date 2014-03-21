class PlaylistsTrack < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :track

  attr_accessible :playlist_id, :track_id, :sort_value

  self.primary_keys = :playlist_id, :track_id

  def self.create_sorted_entry(playlist_id, track_id, order_id)
    pt = PlaylistsTrack.find_or_create_by_playlist_id_and_track_id(playlist_id, track_id)
    pt.update_attributes(:sort_value => order_id)
  end
end
