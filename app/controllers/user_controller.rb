class UserController < ApplicationController
  include MogBeats::Parser

  def update
    @user = current_user
    @user.update_attributes(params['user'])

    ## This NEEEDS to be a RESQUE job.
    ## need to add a job_start,job_finish time to user
    ## only allow user to make 3 requests per day
    ## need to throttle and only do one at a time SLOWLY!

    # 1. login
    mog_login(params['user']['mog_email'], params['mog_password'])

    # 2. get favorites
    favorites = mog_favorites_collect
    @user.parse_favorites(favorites)

    # 3. get playlists
    playlists = mog_playlists_collect

    # we can use the playlist data and update mog_user info
    @user.update_mog_user_data(playlists[0])

    # loop through the playlists,
    # first create user_playlist
    # then collect and create tracks assoc. with playlist
    playlists.each do |playlist|
      @user.parse_playlist(playlist)
      tracks = mog_playlist_tracks_collect(playlist['playlist_id'])
      @user.parse_playlist_tracks(playlist['playlist_id'], tracks)
    end

    # 4. clear the session
    mog_logout
    ### END RESQUE JOB ###

    # need to have a status table for the user
    redirect_to :controller => 'welcome', :action => :index
  end

  def mog_credentials
    @user = current_user
  end

  def albums
    @albums = current_user.albums
  end

  def artists
    @artists = current_user.artists
  end

  def tracks
    @tracks = current_user.tracks
  end

  def playlists
    @playlists = current_user.playlists
  end

  def playlists_tracks
    @playlist = Playlist.find(params['playlist_id'])
    @tracks = @playlist.tracks
  end

  def edit
    @user = current_user
  end


end
