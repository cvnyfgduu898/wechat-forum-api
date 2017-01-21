require './boot'
require './lib/api'

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: :get
  end
end

use Rack::Static, :urls => ['/attachments']

run WechatForum::API