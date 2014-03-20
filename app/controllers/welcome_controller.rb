class WelcomeController < ApplicationController
  include MogBeats::Parser

  def index
    @user = User.find(current_user.id)
    @user_tracks = Tracks.current_user
    #test = test_parse_capybara
    #puts 'what is the result?'
    #puts test.inspect
    #puts 'post_result'
  end

  def get_mog

  end

end
