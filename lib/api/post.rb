require_relative '../services/attachment_fetcher'

module WechatForum
  module Api
    class Post < Grape::API
      resources :post do
        desc 'Get posts.'
        get do
          present WechatForum::Post.all
        end
      end
    end
  end
end