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

    class UserPost < Grape::API
      POST_PARAMS = %w(title description user_openid)

      resources :post do
        desc 'Create post.'
        params do
          requires :title, type: String, desc: 'Post title.', allow_blank: false
          requires :description, type: String, desc: 'Post description.', allow_blank: false
          optional :audio, type: String, desc: 'Audio resource temp url.'
          optional :images, type: Array[String], desc: 'Images resource temp url list.'
        end
        post do
          attachment_fetcher = AttachmentFetcher.new
          post = WechatForum::Post.create(params.select { |k, _| POST_PARAMS.include?(k) })
          if params.audio
            file = attachment_fetcher.fetch("#{post.id}/1.mp3", params.audio)
            WechatForum::Attachment.create({type: :audio, url: file, post_id: post.id})
          end
          if params.images
            params.images.each_with_index do |image_url, index|
              file = attachment_fetcher.fetch("#{post.id}/#{index}.jpg", image_url)
              WechatForum::Attachment.create({type: :image, url: file, post_id: post.id})
            end
          end
          present post
        end

        desc 'Get user post.'
        get do
          present WechatForum::Post.all(user_openid: params.user_openid)
        end

        desc 'Delete a post.'
        params do
          requires :id, type: Integer, desc: 'Post id.'
        end
        delete ':id' do
          WechatForum::Post.get(params.id).destroy
          body false
        end
      end
    end
  end
end