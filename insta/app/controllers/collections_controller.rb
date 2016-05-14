class CollectionsController < ApplicationController
    include 

    def index
      all = Collection.all
      render json: all
    end

    def create
      col = Collection.create(collection_params)

      response = call("https://api.instagram.com/v1/tags/jessehahn/media/recent?min_tag_id=#{}&max_tag_id=#{}&access_token=174180622.1677ed0.f86a491bf33e4f41bad53c20f480a7a0")
      # a = JSON.parse(response.body)
      # p '*'* 999
      # puts a['data']
      # p '*'* 999
      # if a['data'][-1]['caption']['created_time'] > col.max_date.to_i
      #   call({'next': a['pagination']['next_url']})
      relevant?(response, col)
      # response.body.data.each do |post|
      #   if post.caption.created_time >= col.min_date && post.caption.created_time <= col.max_date
      #     p 'make a post'
      #   elsif   
      # end

      render json: response.body
    end

    def show
      
      render json: response.body
    end

    private

    def collection_params
      params.require(:collection).permit(:tag, :min_date, :max_date)
    end

    def call(options)
        # base = "https://api.instagram.com/v1/tags/jessehahn/media/recent?min_tag_id=#{options[:min]}&max_tag_id=#{options[:max]}&access_token=174180622.1677ed0.f86a491bf33e4f41bad53c20f480a7a0"
        # if options['next'] && options['next'] != ''
        #   base = options['next']
        # end
        base = options
        uri = URI.parse(base)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        request = Net::HTTP::Get.new(uri.request_uri)
        p '*'* 99
        puts 'Making a request!!!'
        p '*'* 99
        response = http.request(request)
      end

    def relevant?(response, collection)
      a = JSON.parse(response.body)
      p 'parsed but no request'
      if a['data'][-1]['caption']['created_time'].to_i > collection.max_date.to_i
        p 'too recent'
        p a['data'][-1]['caption']['created_time'].to_i
        new_res = call(a['pagination']['next_url'])
        relevant?(new_res, collection)
        return
      elsif a['data'][-1]['caption']['created_time'].to_i > collection.min_date.to_i
        p 'still more'
        new_res = call(a['pagination']['next_url'])
        relevant?(new_res, collection)
      end
      puts 'collection max'
      puts collection.max_date.to_i
      puts 'collection min'
      puts collection.min_date.to_i

      a['data'].each do |post|
        if post['caption']['created_time'].to_i <= collection.max_date.to_i && post['caption']['created_time'].to_i >= collection.min_date.to_i
          type = post['type'] + 's'
          collection.posts.create(tag_time: post['caption']['created_time'], tag: collection.tag, 
                                  link: post['link'], username: post['user']['username'], user_pic: post['user']['profile_picture'],
                                  media: post[type]['standard_resolution'], media_thumb: post['images']['thumbnail'])
          puts 'MADE A POST!!!!!'
        elsif post['caption']['created_time'].to_i < collection.min_date.to_i
          return
        end

        # puts post['caption']['created_time']
      end
    end
end
