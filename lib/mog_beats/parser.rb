module MogBeats
  module Parser
    require 'rubygems'
    require 'capybara'
    require 'capybara/dsl'
    require 'capybara-webkit'
    include Capybara::DSL

    Capybara.run_server = false
    Capybara.current_driver = :webkit


    def test_parse_capybara
      Capybara.app_host = 'https://mog.com/'
      visit('/m/login')
      all(:xpath, "//input").each { |a| puts a }
    end

    def mog_login(username, password)
      Capybara.app_host = 'https://mog.com/'
      visit('/m/login')
      fill_in 'login', :with => username
      fill_in 'password', :with => password
      #
      #puts @google_plus_page.inspect
      #page.find(:xpath, "//input[@type='submit']").click
      page.find(:xpath, "//div[@title='Login']").click
      sleep(5)
      #page = Nokogiri::HTML.parse(html)
      #puts page
    end

    def mog_favorites_collect
      collection = []
      Capybara.app_host = 'https://mog.com/'
      visit('/m#my_favorites')
      sleep(5)
      # uncomment these 2 lines to make sure source code is valid and we're logged in
      # otherwise leave commented out
      #page = Nokogiri::HTML.parse(html)
      #puts page.inspect
      faves = ['artist','album','track']
      faves.each do |fave_type|
        collection.push(mog_parse_favorites(fave_type))
      end
      return collection
    end

    # return as hash with elements setup for each favorite type
    def mog_parse_favorites(type)
      favorites = {'values' => []}
      html = Nokogiri::HTML(page.evaluate_script("document.getElementById('#{type}_faves').innerHTML"))
      case type
        when 'album'
          puts 'album time!'
          favorites['type'] = 'album'
          html.xpath("//li[@class='clrfx album ui-draggable']").each_with_index do |elem, idx|
            # get the text name (3rd element of <a> tags)
            album = html.xpath("//li[@class='clrfx album ui-draggable'][#{idx+1}]//a")[2]
            image = html.xpath("//li[@class='clrfx album ui-draggable'][2]//img")[0]
            artist = html.xpath("//li[@class='clrfx album ui-draggable'][#{idx+1}]//a")[3]
            favorites['values'].push({'mog_artist_id' => elem['artist_id'], 'mog_album_id' => elem['album_id'], 'album_name' => album['title'], 'artist_name' => artist['title'], 'image_url' => image['src']})
          end

        when 'artist'
          puts 'artist time!'
          favorites['type'] = 'artist'
          if page.has_xpath?("//div[@id='#{type}_faves']/div/ul/li")
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
        else
          return 'fave_type not supported'
      end
        #puts "#{type}_faves:"
        #puts favorites.inspect
        return favorites
    end

    def parse_prefix(elem)
      return elem.gsub('/.+\/(\d+)/',$1)
    end

    def mog_logout
      Capybara.app_host = 'https://mog.com/'
      visit('/m/logout')
    end

  end
end
