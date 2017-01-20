require 'open-uri'

class AttachmentFetcher
  BASE_DIR = 'attachments'

  def initialize
    Dir.mkdir(BASE_DIR) unless File.exists?(BASE_DIR)
    @pool = Concurrent::FixedThreadPool.new(5)
  end

  def fetch(file, url)
    attachment_file = File.join(BASE_DIR, file)
    dir = File.dirname(attachment_file)
    Dir.mkdir(dir) unless File.exist?(dir)

    @pool.post do
      File.open(attachment_file, 'wb') do |f|
        f.write open(url).read
      end
    end

    "/#{attachment_file}"
  end
end