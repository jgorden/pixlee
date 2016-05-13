class CollectionsController < ApplicationController

    def index
      uri = URI.parse("https://api.instagram.com/v1/tags/cats/media/recent?access_token=174180622.1677ed0.f86a491bf33e4f41bad53c20f480a7a0")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)
      render json: response.body
    end
end
