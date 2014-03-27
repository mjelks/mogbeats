require 'spec_helper'
require 'capybara/rspec'

include MogBeats::Parser

MOG_USER_EMAIL = ENV["MOG_USER_EMAIL"]
MOG_PASSWORD = ENV["MOG_PASSWORD"]

describe MogBeats::Parser do
  before :each do
    @user = User.new(:email => MOG_USER_EMAIL, :password => MOG_PASSWORD)
  end

  context "mog_login" do
    after :each do
      mog_logout
    end
    it "should log_in to mog" do
      mog_login(@user.email, @user.password)
      visit 'https://mog.com/m'
      puts page.text.inspect
      expect(page).to have_content 'Just For You'
    end
    it "should throw exception if user already logged in" do
      mog_login(@user.email, @user.password)
      # emulate logging in a second time (should return false)
      return_value = mog_login(@user.email, @user.password)
      return_value.should be_false
    end
  end

  context "mog_favorites_collect" do
     after :each do
       mog_logout
     end
     it "should return a collection" do
       mog_login(@user.email, @user.password)
       collection = mog_favorites_collect
       #puts collection.inspect
       collection.count.should == 3 # artist,album,track assoc. array
       collection[0]['type'].should eq 'artist'
       collection[1]['type'].should eq 'album'
       collection[2]['type'].should eq 'track'
       collection[0]['values'].count.should be > 0
       collection[1]['values'].count.should be > 0
       collection[2]['values'].count.should be > 0
     end
     it "should return false if no collection found (prob not logged in)" do
       collection = mog_favorites_collect
       collection.should be_false
     end
  end

  context "mog_playlists_collect" do
    after :each do
      mog_logout
    end
    it "should return a playlist collection" do
      mog_login(@user.email, @user.password)
      collection = mog_playlists_collect
      #puts collection.inspect
      collection.count.should be > 0
      #{"name"=>"2013 Melodicrock", "playlist_id"=>"2969459", "screen_name"=>"MichaelJelks", "plays"=>"0", "user_id"=>"5661310", "is_public"=>"1", "image_url"=>"https://images.musicnet.com/albums/087/465/027/a.jpeg"}
      collection[0].should include('name', 'playlist_id', 'screen_name', 'plays', 'user_id', 'is_public', 'image_url')
    end
    it "should return false if no collection found (prob not logged in)" do
      collection = mog_playlists_collect
      collection.should be_false
    end
  end

  context "mog_playlist_tracks_collect" do

    before :each do
      # NOTE: you will need to get your own playlist_id
      @playlist = {"name"=>"2013 Melodicrock", "playlist_id"=>"2969459", "screen_name"=>"MichaelJelks", "plays"=>"0", "user_id"=>"5661310", "is_public"=>"1", "image_url"=>"https://images.musicnet.com/albums/087/465/027/a.jpeg"}
    end

    after :each do
      mog_logout
    end

    it "should return a playlist tracks collection" do
      mog_login(@user.email, @user.password)
      collection = mog_playlist_tracks_collect(@playlist['playlist_id'])
      # {"mog_artist_id"=>"185393", "mog_artist_name"=>"Robin Beck", "mog_album_id"=>"87465027", "mog_album_title"=>"Underneath", "mog_track_id"=>"87465029", "track_name"=>"Wrecking Ball", "image_url"=>"https://images.musicnet.com/albums/087/465/027/a.jpeg"}, {"mog_artist_id"=>"185393", "mog_artist_name"=>"Robin Beck", "mog_album_id"=>"87465027", "mog_album_title"=>"Underneath", "mog_track_id"=>"87465031", "track_name"=>"Ain't That Just Like Love", "image_url"=>"https://images.musicnet.com/albums/087/465/027/a.jpeg"}
      collection[0].should include("mog_artist_id", "mog_artist_name", "mog_album_id", "mog_album_title", "mog_track_id", "track_name", "image_url")
    end
    it "should return false if no collection found (prob not logged in)" do
      collection = mog_playlist_tracks_collect(@playlist['playlist_id'])
      collection.should be_false
    end
  end

end