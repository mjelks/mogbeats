class Track < ActiveRecord::Base
  include ApplicationHelper

  has_many :tracks_users
  has_many :users, :through => :tracks_users

  has_and_belongs_to_many :playlists

  attr_accessible :track_mog_id, :track_mog_id, :artist_mog_id, :name, :image_url

  def self.create_user_favorites(tracks, user_id)
    # first generate tracks into the track table if needed
    tracks.each_with_index do |element, idx|
      track = self.create_track(element['album_mog_id'], element['artist_mog_id'], element['mog_track_id'], element['track_name'], element['image_url'])
      # then associate with user
      TracksUser.create_sorted_entry(track.id, user_id, idx)
    end
  end

  def self.create_track(album_mog_id, artist_mog_id, track_mog_id, track_name, image_url="")
    track = self.find_or_create_by_album_mog_id_and_artist_mog_id_and_track_mog_id_and_name (mog_id_cleanup(album_mog_id).to_i,mog_id_cleanup(artist_mog_id).to_i, mog_id_cleanup(track_mog_id).to_i, track_name )
    if image_url?
      track.update_attributes(:image_url => image_url)
    end
    return track
  end
end
