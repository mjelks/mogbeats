class Track < ActiveRecord::Base
  include MogBeats::Formatter

  has_many :tracks_users
  has_many :users, :through => :tracks_users

  has_many :playlists_tracks
  has_many :playlists, :through => :playlists_tracks

  belongs_to :album
  belongs_to :artist

  has_and_belongs_to_many :playlists

  attr_accessible :name, :track_mog_id, :album_id, :artist_id

  def self.create_user_favorites(tracks, user_id)
    # first generate tracks into the track table if needed
    tracks.each_with_index do |element, idx|
      track = self.create_track(element['mog_album_id'], element['mog_artist_id'], element['mog_track_id'], element['track_name'], element['image_url'], element['mog_album_title'], element['mog_artist_name'])
      # then associate with user
      TracksUser.create_sorted_entry(track.id, user_id, idx)
    end
  end

  def self.create_track(album_mog_id, artist_mog_id, track_mog_id, track_name, image_url, album_name, artist_name)
    album = Album.create_album(album_mog_id,album_name,image_url)
    artist = Artist.create_artist(artist_mog_id, artist_name)
    track = self.find_or_create_by_track_mog_id_and_album_id_and_artist_id(track_mog_id, album.id, artist.id)
    track.update_attributes(
        :name => track_name
    )

    return track
  end

  def artist_name
    return self.artist.name
  end

  def album_name
    return self.album.name
  end

  def image_url
    return self.album.image_url
  end

end
