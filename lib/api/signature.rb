require_relative '../services/wechat_service'

module WechatForum
  module Api
    class Signature < Grape::API
      resources :signature do
        desc 'Get signature for wechat api.'
        params do
          requires :noncestr, type: String, desc: 'Random string.', allow_blank: false
          requires :timestamp, type: Integer, desc: 'Timestamp.', allow_blank: false
          requires :url, type: String, desc: 'Url.', allow_blank: false
        end
        get do
          { signature: WechatService.signature(params.noncestr, params.timestamp, params.url) }
        end
      end
    end
  end
end