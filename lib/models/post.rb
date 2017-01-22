require_relative 'attachment'

module WechatForum
  class Post
    include DataMapper::Resource

    property :id, Serial

    property :title, String, required: true
    property :description, Text, required: true

    property :created_at, DateTime
    property :updated_at, DateTime

    belongs_to :user
    has 1, :audio, WechatForum::Attachment, type: :audio, constraint: :destroy
    has n, :images, WechatForum::Attachment, type: :image, constraint: :destroy

    class Entity < Grape::Entity
      expose :id, :title, :description, :user_openid
      expose :audio, using: WechatForum::Attachment::Entity
      expose :images, using: WechatForum::Attachment::Entity
      expose :created_at, :updated_at
    end
  end
end