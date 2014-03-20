class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :mog_email, :beats_email
  # attr_accessible :title, :body
  has_many :playlists

  has_many :albums_users, :dependent => :destroy
  has_many :albums, through: :albums_users

  has_many :artists_users
  has_many :artists, :through => :artists_users

  has_many :tracks_users, :dependent => :destroy
  has_many :tracks, :through => :tracks_users

  include Gravtastic
  gravtastic


  #scope :is_unit_compatible, where(:campaign_type => ["giveaway", "coupon", "interstitial"])

end
