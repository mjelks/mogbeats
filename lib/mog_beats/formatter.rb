module MogBeats
  module Formatter
    def self.mog_image_cleanup(image_url)
      return image_url.gsub(/^\/\/(.+)/,'http://\1')
    end

    def self.mog_id_cleanup(mog_id)
      return mog_id.to_s.gsub(/.*?\/?(\d+)/,'\1')
    end
  end
end