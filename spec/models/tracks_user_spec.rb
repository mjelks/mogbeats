require 'spec_helper'

describe TracksUser do
  context "create_sorted_entry" do
    before :each do
      @track = mock_model Track
      @user_id = 27
      @tracks_user = TracksUser.new(:Track_id => @track.id, :user_id => @user_id)
    end
    it "should find_or_create entry" do
       TracksUser.stub(:find_or_create_by_track_id_and_user_id).and_return(@tracks_user)
       TracksUser.create_sorted_entry(@track.id, @user_id, 3).should be_true
    end
  end

end