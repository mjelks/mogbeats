require 'spec_helper'

describe ArtistsUser do
  context "create_sorted_entry" do
    before :each do
      @artist = mock_model Artist
      @user_id = 27
      @artists_user = ArtistsUser.new(:artist_id => @artist.id, :user_id => @user_id)
    end
    it "should find_or_create entry" do
       ArtistsUser.stub(:find_or_create_by_artist_id_and_user_id).and_return(@artists_user)
       ArtistsUser.create_sorted_entry(@artist.id, @user_id, 3).should be_true
    end
  end

end