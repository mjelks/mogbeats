require 'spec_helper'

describe AlbumsUser do
  context "create_sorted_entry" do
    before :each do
      @album = mock_model Album
      @user_id = 27
      @albums_user = AlbumsUser.new(:album_id => @album.id, :user_id => @user_id)
    end
    it "should find_or_create entry" do
       AlbumsUser.stub(:find_or_create_by_album_id_and_user_id).and_return(@albums_user)
       AlbumsUser.create_sorted_entry(@album.id, @user_id, 3).should be_true
    end
  end

end