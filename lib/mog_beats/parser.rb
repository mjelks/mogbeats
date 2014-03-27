module MogBeats
  module Parser
    require 'rubygems'
    require 'capybara'
    require 'capybara/dsl'
    require 'capybara/poltergeist'
    include Capybara::DSL

    PHANTOM_JS_LOCATION = '/opt/phantomjs'
    USER_AGENT = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.74.9 (KHTML, like Gecko) Version/7.0.2 Safari/537.74.9'

    Capybara.run_server = false
    Capybara.register_driver :poltergeist do |app|
      #Capybara::Poltergeist::Driver.new(app, {:phantomjs => '/opt/phantomjs', :js_errors => false, :inspector => true, :timeout => 300})
      Capybara::Poltergeist::Driver.new(app, {:phantomjs => PHANTOM_JS_LOCATION, :js_errors => false, :timeout => 180, :phantomjs_options => ['--load-images=no', '--ignore-ssl-errors=yes', '--web-security=false']})
    end
    Capybara.default_driver = :poltergeist
    Capybara.javascript_driver = :poltergeist

    #def test_parse_capybara
    #  Capybara.app_host = 'https://mog.com/'
    #  visit('/m')
    #  all(:xpath, "//input").each { |a| puts a }
    #end

    def mog_login(username, password)
      page.driver.headers = { "User-Agent" => USER_AGENT, "Referer" => "http://digg.com/reader" }
      Capybara.app_host = 'https://mog.com/'
      visit('/m/login')
      sleep(5)
      begin
        fill_in 'login', :with => username
        fill_in 'password', :with => password
        page.find(:xpath, "//div[@title='Login']").click
        sleep(5)
      rescue Capybara::ElementNotFound
        return false
      end
    end

    def mog_favorites_collect
      collection = []
      Capybara.app_host = 'https://mog.com/'
      visit('/m#my_favorites')
      sleep(5)
      if signed_in(page)
        # uncomment these 2 lines to make sure source code is valid and we're logged in
        # otherwise leave commented out
        #page = Nokogiri::HTML.parse(html)
        #puts page.inspect
        faves = ['artist','album','track']
        faves.each do |fave_type|
          collection.push(mog_parse_favorites(fave_type, page))
        end
      else
        collection = false
      end
      return collection
    end

    # return as hash with elements setup for each favorite type
    def mog_parse_favorites(type, mog_page)
      favorites = {'values' => []}
      html = Nokogiri::HTML(mog_page.evaluate_script("document.getElementById('#{type}_faves').innerHTML"))
      case type
        when 'album'
          puts 'album time!'
          favorites['type'] = 'album'
          html.xpath("//li[@class='clrfx album ui-draggable']").each_with_index do |elem, idx|
            # get the text name (3rd element of <a> tags)
            album = html.xpath("//li[@class='clrfx album ui-draggable'][#{idx+1}]//a")[2]
            image = html.xpath("//li[@class='clrfx album ui-draggable'][#{idx+1}]//img")[0]
            artist = html.xpath("//li[@class='clrfx album ui-draggable'][#{idx+1}]//a")[3]
            favorites['values'].push({'mog_artist_id' => elem['artist_id'], 'mog_album_id' => elem['album_id'], 'album_name' => album['title'], 'artist_name' => artist['title'], 'image_url' => image['src']})
          end

        when 'artist'
          puts 'artist time!'
          favorites['type'] = 'artist'
          if mog_page.has_xpath?("//div[@id='#{type}_faves']/div/ul/li")
            html.xpath("//li//a").each do |elem|
              mog_value = elem['href']
              favorites['values'].push({'mog_artist_id' => mog_value, 'artist_name' => elem.children.last.text})
            end
          end

        when 'track'
          puts 'track time!'
          favorites['type'] = 'track'
          html.xpath("//li[@class='track clrfx ui-draggable custom_context']").each_with_index do |elem, idx|
            track = html.xpath("//li[@class='track clrfx ui-draggable custom_context']")[idx]
            #track = html.xpath("//li[@class='track clrfx ui-draggable custom_context']/span")[idx]
            #artist = html.xpath("//li[@class='track clrfx ui-draggable custom_context']//a[1]")[idx]
            #album = html.xpath("//li[@class='track clrfx ui-draggable custom_context']//a[2]")[idx]
            #favorites['values'].push({'mog_artist_id' => artist['href'], 'mog_artist_name' => artist['title'], 'mog_album_id' => album['href'], 'mog_album_title' => album['title'], 'mog_track_id' => '', 'track_name' => track_meta['title']})
            favorites['values'].push({'mog_artist_id' => track['artist_id'], 'mog_artist_name' => track['artist_name'], 'mog_album_id' => track['album_id'], 'mog_album_title' => track['album_name'], 'mog_track_id' => track['track_id'], 'track_name' => track['track_name'], 'image_url' => track['album_image']})
          end
        #else
        #  return 'fave_type not supported'
      end
        #puts "#{type}_faves:"
        #puts favorites.inspect
        return favorites
    end

    def mog_playlists_collect
      playlists = []
      Capybara.app_host = 'https://mog.com/'
      visit('/m#my_playlists')
      sleep(10)
      #<li
      # class="clrfx mini playlist ui-draggable" playlist_id="1268560"
      # name="80s New Wave" description=""
      # screen_name="MichaelJelks"
      # track_count="297"
      # plays="0"
      # user_id="5661310"
      # updated="1328218857"
      # is_public="0"
      # image_url="https://images.musicnet.com/albums/003/363/245/s.jpeg" tracks="">
      if signed_in(page)
        page.all(:xpath, '//ul[@class="playlists clrfx"]/li').each { |li| obj = {'name' => li['name'],'playlist_id' => li['playlist_id'],'screen_name' => li['screen_name'],'plays' => li['plays'],'user_id' => li['user_id'],'is_public' => li["is_public"],'image_url' => li['image_url']}; playlists.push(obj) }
      else
        # TODO: properly throw and catch exception at this point
        puts 'you need to login again, or we need to wait a little longer to process the page'
        playlists = false
      end

      return playlists
    end

    def signed_in(mog_page)
      return mog_page.text.include?('sign in with your MOG details') || mog_page.text.include?('Hmmm, that page no longer seems') ? false : true
    end

    def mog_playlist_tracks_collect(playlist_id)
      playlist_tracks = []
      Capybara.app_host = 'https://mog.com/'
      visit('/m#playlist/'+playlist_id.to_s)
      sleep(2)

      #<li
      # class="track clrfx ui-draggable playlist_context"
      # track_id="516713"
      # track_name="So Far Away"
      # album_id="516711"
      # album_name="Brothers In Arms"
      # artist_id="8489"
      # artist_name="Dire Straits"
      # album_image="https://images.musicnet.com/albums/000/516/711/a.jpeg"
      # seconds="312" duration="312" context="playlist_1270954" style="">

      if signed_in(page)
        page.all(:xpath, "//li[@class='track clrfx ui-draggable playlist_context']").each { |track| playlist_tracks.push({'mog_artist_id' => track['artist_id'], 'mog_artist_name' => track['artist_name'], 'mog_album_id' => track['album_id'], 'mog_album_title' => track['album_name'], 'mog_track_id' => track['track_id'], 'track_name' => track['track_name'], 'image_url' => track['album_image']}) }
      else
        # TODO: properly throw and catch exception at this point
        puts 'you need to login again, or we need to wait a little longer to process the page'
        playlist_tracks = false
      end

      return playlist_tracks
    end

    def mog_logout
      Capybara.app_host = 'https://mog.com/'
      visit('/m')
      sleep(2)
      #page.execute_script("document.getElementById('menu-holder').getElementsByClassName('menu-pop-down')[0].getElementsByTagName('ul')[0].style.display = 'block'")
      #page.find(:xpath, "//div[@id='dropdown-menus']/div/div[1]/div/ul/li[3]/a",:visible => false).click
      page.execute_script('localStorage.clear()')
      page.execute_script('sessionStorage.clear()')
      Capybara.reset_sessions!
    end

  end
end
