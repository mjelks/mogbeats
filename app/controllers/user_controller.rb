class UserController < ApplicationController
  include MogBeats::Parser

  def update
    @user = current_user
    @user.update_attributes(params['user'])

    # 1. logout first, to make sure other session not in place
    # 2. login
    # 3. get favorites
    # 4. get playlists

    #puts 'attempting to login!'
    #page = test_parse_capybara
    #page = mog_login(params['user']['mog_email'], params['mog_password'])
    #logout_of_mog
    #puts page.inspect

    puts 'hey!'
    puts 'what is the result?'
    #mog_login(params['user']['mog_email'], params['mog_password'])
    results = mog_favorites_collect

    puts 'post_result'
    #puts results.inspect
    results.each do |favorite|
      case favorite['type']
        when 'album'
          Album.create_user_favorites(favorite['values'], current_user.id)
        when 'artist'
          Artist.create_user_favorites(favorite['values'], current_user.id)
        when 'track'
          Track.create_user_favorites(favorite['values'], current_user.id)
      end
    end


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



end
