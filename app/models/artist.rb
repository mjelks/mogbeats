class Artist < ActiveRecord::Base
  include MogBeats::Formatter

  has_many :artists_users
  has_many :users, :through => :artists_users

  has_many :tracks

  attr_accessible :name, :mog_id

  def self.create_user_favorites(artists, user_id)
    # first generate artists into the artist table if needed
    artists.each_with_index do |element, idx|
      artist = self.create_artist(element['mog_artist_id'], element['artist_name'])
      # then associate with user
      ArtistsUser.create_sorted_entry(artist.id, user_id, idx)
    end
  end

  def self.create_artist(mog_id, artist_name)
    return self.find_or_create_by_mog_id_and_name(MogBeats::Formatter.mog_id_cleanup(mog_id).to_i, artist_name)
  end

  def artist_name
    @name = self.name
  end

end
