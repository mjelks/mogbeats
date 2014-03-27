class MogPlaylistTracksCollect
  extend MogBeats::Parser
  @queue = :mog
  def self.perform(user_id, username, password, playlist)
    mog_logout
    mog_login(username, password)

    @user = User.find(user_id)

    @user.parse_playlist(playlist)
    tracks = mog_playlist_tracks_collect(playlist['playlist_id'])
    if tracks
      @user.parse_playlist_tracks(playlist['playlist_id'], tracks)
    else
      @user.update_attributes(:mog_process_status => 'Unable to process tracks for the playlist ' + playlist['name'])
    end

    # done with processing, good or bad. now user can try again if needed
    @user.update_attributes(:mog_process => false)
  end
end