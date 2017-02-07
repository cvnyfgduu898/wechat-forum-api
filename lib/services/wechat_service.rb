class WechatService
  class << self
    def signature(noncestr, timestamp, url)
      raw_signature = "jsapi_ticket=#{ticket}&noncestr=#{noncestr}&timestamp=#{timestamp}&url=#{url}"
      OpenSSL::Digest::SHA1.new(raw_signature).to_s
    end

    private

    def ticket
      refresh_ticket if !defined?(@@ticket) || @@ticket_expiry <= Time.now
      @@ticket
    end

    def refresh_ticket
      current_time = Time.now
      ticket_uri = URI("https://api.wechat.com/cgi-bin/ticket/getticket?access_token=#{access_token}&type=jsapi")
      response = JSON.parse(Net::HTTP.get_response(ticket_uri).body)
      @@ticket = response['ticket']
      @@ticket_expiry = current_time + response['expires_in']
    end

    def access_token
      access_token_uri = URI("https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=#{ENV['APP_ID']}&secret=#{ENV['APP_SECRET']}")
      JSON.parse(Net::HTTP.get_response(access_token_uri).body)['access_token']
    end
  end
end