##puts 'HEY!!!!'
## 1. login
#mog_login(params['user']['mog_email'], params['mog_password'])
##test_parse_capybara()
## 2. get favorites
#favorites = mog_favorites_collect
#@user.parse_favorites(favorites)
#
## 3. get playlists
#playlists = mog_playlists_collect
#
## we can use the playlist data and update mog_user info
#@user.update_mog_user_data(playlists[0])
#
## loop through the playlists,
## first create user_playlist
## then collect and create tracks assoc. with playlist
#playlists.each do |playlist|
#  @user.parse_playlist(playlist)
#  tracks = mog_playlist_tracks_collect(playlist['playlist_id'])
#  @user.parse_playlist_tracks(playlist['playlist_id'], tracks)
#end
#
## 4. clear the session
#mog_logout
#### END RESQUE JOB ###

### the commented out code above was the long single threaded process version of the now (3 chunked) code
# first we login and collect user favorites, then save the user favorites to DB
# second we parse the playlists
# third we loop through each playlist, and each playlist gets a separate job to process

class MogUserCollect
  extend MogBeats::Parser
  @queue = :mog
  def self.perform(user_id, username, password)
    @user = User.find(user_id)
    ## clear any stale sessions
    mog_logout

    ## 1. login
    mog_login(username, password)

    ## 2. get favorites
    favorites = mog_favorites_collect
    if favorites
      @user.parse_favorites(favorites)
    else
      # log error for user ('no favorites collected, please try again, and confirm your username and password')
      @user.update_attributes(:mog_process_status => '<li>No favorites collected, please try again, and confirm your username and password.</li>')
    end

    @user.update_attributes(:mog_process => false)

    # 3. enqueue the playlists data
    Resque.enqueue(MogPlaylistsCollect, user_id, username, password)
  end
end
