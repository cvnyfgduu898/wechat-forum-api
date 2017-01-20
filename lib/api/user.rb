require_relative 'post'

module WechatForum
  module Api
    class User < Grape::API
      resources :user do
        desc 'Create user'
        params do
          requires :openid, type: String, desc: 'Unique wechat open id', allow_blank: false
          requires :nickname, type: String, desc: 'User nickname', allow_blank: false
          optional :head_img_url, type: String, desc: 'User head image url'
        end
        post do
          present WechatForum::User.create(params)
        end

        params do
          requires :user_openid, type: String, desc: 'Unique wechat open id'
        end
        route_param :user_openid do
          mount Api::UserPost
        end
      end
    end
  end
end