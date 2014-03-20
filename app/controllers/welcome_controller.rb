class WelcomeController < ApplicationController
  include MogBeats::Parser

  def index
    @foo = 'baz'
    @user = User.find(current_user.id)
    #test = test_parse_capybara
    #puts 'what is the result?'
    #puts test.inspect
    #puts 'post_result'
  end

  def get_mog

  end

end
