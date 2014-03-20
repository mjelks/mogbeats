class UserController < ApplicationController
  include MogBeats::Parser

  def update
    @user = current_user
    @user.update_attributes(params['user'])

    # logout first, to make sure other session not in place
    # login
    # get favorites
    # get playlists
    #puts 'attempting to login!'
    #page = test_parse_capybara
    #page = mog_login(params['user']['mog_email'], params['mog_password'])
    #logout_of_mog
    #puts page.inspect

    puts 'hey!'
    puts 'what is the result?'
    #login_to_mog(params['user']['mog_email'], params['mog_password'])
    results = mog_favorites_collect
    puts 'post_result'


    redirect_to :controller => 'welcome', :action => :index
  end



end
