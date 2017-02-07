require_relative 'api/user'
require_relative 'api/post'
require_relative 'api/signature'
require 'grape-swagger'

module WechatForum
  class API < Grape::API
    format :json
    prefix :api

    before do
      header 'Access-Control-Allow-Origin', '*'
      header 'Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept, Api-Key'
    end

    mount Api::Signature
    mount Api::User
    mount Api::Post

    add_swagger_documentation
  end
end
