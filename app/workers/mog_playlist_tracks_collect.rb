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
      # TODO: 'unable to process tracks for the playlist ' + playlist['name']
    end

  end
end