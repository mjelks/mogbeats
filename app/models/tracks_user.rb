class TracksUser < ActiveRecord::Base
  belongs_to :track
  belongs_to :user

  attr_accessible :track_id, :user_id, :sort_value

  self.primary_keys = :track_id, :user_id

  def self.create_sorted_entry(track_id, user_id, order_id)
    tu = TracksUser.find_or_create_by_track_id_and_user_id(track_id, user_id)
    tu.update_attributes(:sort_value => order_id)
  end
end