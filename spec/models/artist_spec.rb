require 'spec_helper'

describe Artist do

  context "create_user_favorites" do
    before :each do
      @user_id = 2
      @favorites = {"values"=>[{"mog_artist_id"=>"#artist/423779", "artist_name"=>"Hansen"}],
                    "type"=>"artist"}
    end

    it "should add favorites for a user" do
      artist1 = @favorites['values'][0]
      @artist = Artist.new(:name => artist1['artist_name'], :mog_id =>  MogBeats::Formatter.mog_id_cleanup(artist1['mog_artist_id']))
      Artist.stub(:create_artist).and_return(@artist)
      ArtistsUser.stub(:create_sorted_entry).and_return true
      Artist.create_user_favorites(@favorites['values'], @user_id).should be_true
    end
  end

  context "create_artist" do
    it "should create an artist" do
      artist_name = 'Fooz'
      mog_id = '#artist/94483783'
      @artist = Artist.new(:name => artist_name, :mog_id => MogBeats::Formatter.mog_id_cleanup(mog_id))
      Artist.stub(:find_or_create_by_mog_id_and_name).and_return(@artist)
      result = Artist.create_artist(mog_id, artist_name)
      result.should eq @artist
      result.mog_id.should == 94483783
    end

  end

end
