class UserController < ApplicationController
  include MogBeats::Parser

  def update
    @user = current_user
    @user.update_attributes(params['user'])

    ## This NEEEDS to be a RESQUE job.
    ## need to throttle and only do one at a time SLOWLY!

    # 1. login
    mog_login(params['user']['mog_email'], params['mog_password'])

    # 2. get favorites
    favorites = mog_favorites_collect
    # 3. get playlists

    # 4. clear the session
    mog_logout

    @user.parse_favorites(favorites)
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

  def edit
    @user = current_user
  end


end
