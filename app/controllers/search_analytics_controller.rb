class SearchAnalyticsController < ApplicationController
    def index
      @search_analytics = Log.select("id, query, ip_address, count(*) as count").group("id, query, ip_address").order("count DESC").limit(20)
      render json: @search_analytics
    end
  end
  