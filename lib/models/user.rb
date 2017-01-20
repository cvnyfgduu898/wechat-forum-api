module WechatForum
  class User
    include DataMapper::Resource

    property :openid, String, required: true, key: true
    property :nickname, String, required: true
    property :head_img_url, URI

    property :created_at, DateTime
    property :updated_at, DateTime

    has n, :post

    class Entity < Grape::Entity
      expose :openid, :nickname, :head_img_url
    end
  end
end