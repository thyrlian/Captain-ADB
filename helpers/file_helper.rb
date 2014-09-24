module CaptainADB
  module FileHelper
    def get_screenshots_files(dir)
      screenshots = []
      regex = /^screenshot.*\.png$/
      begin
        Dir.foreach(dir) do |f|
          if f.match(regex)
            screenshots.push(f)
          end
        end
      rescue Exception => e
      end
      screenshots
    end
  end
end