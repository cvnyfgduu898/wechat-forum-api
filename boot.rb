env = (ENV['RACK_ENV'] || :development).to_sym

require 'bundler'
Bundler.require :default, env

Dir["#{File.dirname(__FILE__)}/lib/models/**/*.rb"].each { |f| require f }
DataMapper.finalize
DataMapper::Model.raise_on_save_failure = true
if env == :development
  DataMapper::Logger.new($stdout, :debug)
  ENV['API_KEY'] = '123'
end

db_config = {
  staging: ENV['DATABASE_URL'],
  development: 'postgres://wechat_forum:@localhost/wechat_forum_api_development',
}[env]

DataMapper.setup(:default, db_config)