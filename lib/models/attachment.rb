module WechatForum
  class Attachment
    include DataMapper::Resource

    property :id, Serial

    property :type, Enum[:audio, :image], required: true
    property :url, String, required: true

    property :created_at, DateTime
    property :updated_at, DateTime

    belongs_to :post

    class Entity < Grape::Entity
      expose :url
    end
  end
end