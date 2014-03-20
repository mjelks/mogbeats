class Track < ActiveRecord::Base
  include MogBeats::Formatter

  has_many :tracks_users
  has_many :users, :through => :tracks_users

  belongs_to :albums
  belongs_to :artists

  has_and_belongs_to_many :playlists

  attr_accessible :track_mog_id, :track_mog_id, :artist_mog_id, :name, :image_url, :album_name, :artist_name

  def self.create_user_favorites(tracks, user_id)
    # first generate tracks into the track table if needed
    tracks.each_with_index do |element, idx|
      track = self.create_track(element['mog_album_id'], element['mog_artist_id'], element['mog_track_id'], element['track_name'], element['image_url'], element['mog_album_title'], element['mog_artist_name'])
      # then associate with user
      TracksUser.create_sorted_entry(track.id, user_id, idx)
    end
  end

  def self.create_track(album_mog_id, artist_mog_id, track_mog_id, track_name, image_url, album_name, artist_name)
    track = self.find_or_create_by_album_mog_id_and_artist_mog_id_and_track_mog_id(
        MogBeats::Formatter.mog_id_cleanup(album_mog_id).to_i,
        MogBeats::Formatter.mog_id_cleanup(artist_mog_id).to_i,
        MogBeats::Formatter.mog_id_cleanup(track_mog_id).to_i,
    )
    track.update_attributes(
        :name => track_name,
        :image_url => MogBeats::Formatter.mog_image_cleanup(image_url),
        :album_name => album_name,
        :artist_name => artist_name
    )

    return track
  end
end
