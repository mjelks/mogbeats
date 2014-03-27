# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140327053955) do

  create_table "albums", :force => true do |t|
    t.integer  "mog_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "image_url"
  end

  add_index "albums", ["mog_id", "name"], :name => "index_albums_on_mog_id_and_name", :unique => true

  create_table "albums_users", :id => false, :force => true do |t|
    t.integer "album_id"
    t.integer "user_id"
    t.integer "sort_value"
  end

  add_index "albums_users", ["album_id", "user_id"], :name => "index_albums_users_on_album_id_and_user_id", :unique => true

  create_table "artists", :force => true do |t|
    t.integer  "mog_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "artists", ["mog_id", "name"], :name => "index_artists_on_mog_id_and_name", :unique => true

  create_table "artists_users", :id => false, :force => true do |t|
    t.integer "artist_id"
    t.integer "user_id"
    t.integer "sort_value"
  end

  add_index "artists_users", ["artist_id", "user_id"], :name => "index_artists_users_on_artist_id_and_user_id", :unique => true

  create_table "playlists", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "mog_id"
    t.string   "image_url"
    t.boolean  "is_public"
    t.integer  "plays"
    t.string   "screen_name"
  end

  create_table "playlists_tracks", :id => false, :force => true do |t|
    t.integer "playlist_id"
    t.integer "track_id"
    t.integer "sort_value"
  end

  add_index "playlists_tracks", ["playlist_id", "track_id"], :name => "index_playlists_tracks_on_playlist_id_and_track_id"

  create_table "tracks", :force => true do |t|
    t.string   "name"
    t.integer  "track_mog_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "album_id"
    t.integer  "artist_id"
  end

  add_index "tracks", ["track_mog_id", "album_id", "artist_id"], :name => "index_tracks_on_track_mog_id_and_album_id_and_artist_id", :unique => true

  create_table "tracks_users", :id => false, :force => true do |t|
    t.integer "track_id"
    t.integer "user_id"
    t.integer "sort_value"
  end

  add_index "tracks_users", ["track_id", "user_id"], :name => "index_tracks_users_on_track_id_and_user_id", :unique => true

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "mog_email"
    t.string   "beats_email"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "mog_screen_name"
    t.integer  "mog_user_id"
    t.boolean  "mog_process",            :default => false
    t.string   "mog_process_status"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
