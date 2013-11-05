require 'net/http'

module Notifier
  API_ENDPOINT = 'http://0.0.0.0:3000/notifications'

  # Notifier::api_key = 'f7c7f80725bd'
  def self.api_key
    @api_key
  end

  def self.api_key=(api_key)
    @api_key = api_key
  end

  # Notifier::send do |n|
  #   n[:type] = 'alert'
  #   n[:message] = 'Test from within the ruby module!'
  # end
  def self.send(&block)
    notification = {type: nil, message: nil}
    yield notification
    # TODO make this asyc? non blocking
    self.make_api_call(notification)
  end

  def self.make_api_call(notification)
    type = notification[:type]
    message = notification[:message]

    uri = URI(API_ENDPOINT)
    req = Net::HTTP::Post.new(uri)
    req.set_form_data('api_key' => @api_key, 'type' => type, 'message' => message)

    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end

    case res
    when Net::HTTPSuccess, Net::HTTPRedirection
      # OK
    else
      res.value
    end
  end

end

