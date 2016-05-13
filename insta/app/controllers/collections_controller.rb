class CollectionsController < ApplicationController

    def index
      all = Collection.all
      render json: all
    end

    def create
      col = Collection.create(collection_params)
      render json: col
    end

    def show
      base = "https://api.instagram.com/v1/tags/cats/media/recent?min_tag_id=#{}&max_tag_id=#{}&access_token=174180622.1677ed0.f86a491bf33e4f41bad53c20f480a7a0"
      uri = URI.parse(base)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)
      render json: response.body
    end

    private

    def collection_params
      params.require(:collection).permit(:tag, :min_date, :max_date)
    end
end
