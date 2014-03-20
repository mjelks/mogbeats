class WelcomeController < ApplicationController
  include MogBeats::Parser

  def index
    @user = User.find(current_user.id)
    @artists_count = current_user.artists.count
    @albums_count = current_user.albums.count
    @tracks_count = current_user.tracks.count
    @playlists_count = current_user.playlists.count
    @total_count = @artists_count + @albums_count + @tracks_count + @playlists_count
  end

  def get_mog

  end

end
