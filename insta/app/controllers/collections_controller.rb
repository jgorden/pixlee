class CollectionsController < ApplicationController

    def index
      all = Collection.all
      render json: all
    end

    def create
      col = Collection.create(collection_params)
      response = call("https://api.instagram.com/v1/tags/jessehahn/media/recent?min_tag_id=#{}&max_tag_id=#{}&access_token=174180622.1677ed0.f86a491bf33e4f41bad53c20f480a7a0")
      relevant?(response, col)
      render json: col.posts
    end

    def show
      collection = Collection.find(params[:id]).posts
      p 'yessss'
      render json: collection
    end

    private

    def collection_params
      params.require(:collection).permit(:tag, :min_date, :max_date)
    end

    def call(url)
        base = url
        uri = URI.parse(base)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        request = Net::HTTP::Get.new(uri.request_uri)
        response = http.request(request)
      end

    def relevant?(response, collection)
      body = JSON.parse(response.body)
      if body['data'][-1]['caption']['created_time'].to_i > collection.max_date.to_i
        p body['data'][-1]['caption']['created_time'].to_i
        new_res = call(body['pagination']['next_url'])
        relevant?(new_res, collection)
        return
      elsif body['data'][-1]['caption']['created_time'].to_i > collection.min_date.to_i
        new_res = call(body['pagination']['next_url'])
        relevant?(new_res, collection)
      end

      body['data'].each do |post|
        if post['caption']['created_time'].to_i <= collection.max_date.to_i && post['caption']['created_time'].to_i >= collection.min_date.to_i
          type = post['type'] + 's'
          collection.posts.create(tag_time: post['caption']['created_time'], tag: collection.tag, 
                                  link: post['link'], username: post['user']['username'], user_pic: post['user']['profile_picture'],
                                  media: post[type]['standard_resolution']['url'], media_thumb: post['images']['thumbnail']['url'])
        elsif post['caption']['created_time'].to_i < collection.min_date.to_i
          return
        end
      end
    end
end
