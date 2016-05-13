class CollectionsController < ApplicationController

    def index
      render json: { testing: 'test' }
    end
end
