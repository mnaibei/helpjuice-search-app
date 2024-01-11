class LogsController < ApplicationController
    def index
    end
    def search
        searchquery = params[:searchquery]
        ip_address = request.remote_ip

        Log.create(query: searchquery, ip_address: ip_address)

        render json: { message: "Search query logged." }
    end
end
