class Artist < ActiveRecord::Base
  include ApplicationHelper

  has_many :artists_users
  has_many :users, :through => :artists_users

  # attr_accessible :title, :body
  has_and_belongs_to_many :users
end
