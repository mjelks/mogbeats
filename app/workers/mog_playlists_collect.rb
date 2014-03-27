class MogPlaylistsCollect
  extend MogBeats::Parser
  @queue = :mog
  def self.perform(user_id, username, password)
    mog_logout
    mog_login(username, password)

    playlists = mog_playlists_collect
    if playlists
      @user = User.find(user_id)
      @user.update_mog_user_data(playlists[0])

      # step 4 enqueue each playlist into its own resque task
      playlists.each do |playlist|
        Resque.enqueue(MogPlaylistTracksCollect, user_id, username, password, playlist)
      end
    else
      @user.update_attributes(:mog_process_status => 'Playlists not generated, please try again')
    end

  end
end