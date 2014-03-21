class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :mog_email, :beats_email, :mog_screen_name, :mog_user_id
  # attr_accessible :title, :body
  has_many :playlists

  has_many :albums_users, :dependent => :destroy
  has_many :albums, through: :albums_users

  has_many :artists_users
  has_many :artists, :through => :artists_users

  has_many :tracks_users, :dependent => :destroy
  has_many :tracks, :through => :tracks_users

  include Gravtastic
  gravtastic

  def parse_favorites(favorites)
    favorites.each do |favorite|
      case favorite['type']
        when 'album'
          Album.create_user_favorites(favorite['values'], self.id)
        when 'artist'
          Artist.create_user_favorites(favorite['values'], self.id)
        when 'track'
          Track.create_user_favorites(favorite['values'], self.id)
      end
    end
  end

  def update_mog_user_data(data)
    self.update_attributes(:mog_screen_name => data['screen_name'], :mog_user_id => data['user_id'])
  end

  def parse_playlist(playlist)
    playlist = Playlist.find_or_create_by_mog_id_and_user_id(playlist['playlist_id'], self.id)
    playlist.update_attributes(:name => playlist['name'], :image_url => playlist['image_url'], :is_public => playlist['is_public'], :plays => playlist['plays'])
  end

  def parse_playlist_tracks(playlist_mog_id, tracks)
    playlist = Playlist.find_by_mog_id_and_user_id(playlist_mog_id, self.id)
    tracks.each_with_index do |element,idx|
      track = Track.create_track(element['mog_album_id'], element['mog_artist_id'], element['mog_track_id'], element['track_name'], element['image_url'], element['mog_album_title'], element['mog_artist_name'])
      PlaylistsTrack.create_sorted_entry(playlist.id, track.id, idx)
    end
  end

end
