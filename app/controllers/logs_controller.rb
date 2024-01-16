require 'amatch'
class LogsController < ApplicationController
    def index
    end
  
    def search
      search_query = params[:searchquery]
      ip_address = request.remote_ip
  
      if search_query.present? && query_completed?(search_query)
        # Log the completed search query
        log_search(search_query, ip_address)
      else
       
      end
  
      render json: { message: "Search query processed." }
    end
  
    # def history
    # # Get user's IP address
    #   ip_address = request.remote_ip
    #   # Fetch logs associated with the user's IP address
    #   logs = Log.where(ip_address: ip_address).select { |log| query_completed?(log.query) }
  
    #   render json: { history: logs.map(&:query) }
    # end

    def history
      # Fetch all logs with completed search queries
      logs = Log.all.select { |log| query_completed?(log.query) }
    
      # Extract unique search queries from the logs
      unique_queries = logs.map(&:query).uniq
    
      render json: { history: unique_queries }
    end
  
    private
  
    # def query_completed?(search_query)
    #   search_query.ends_with?("")
    # end
  
    def query_completed?(search_query)
      # Check if the search query is different from the previous query
      search_query != ""
    end

    
    # def log_search(search_query, ip_address)
    #     # Check if a log with the same IP address already exists
    #     existing_log = Log.where(ip_address: ip_address).order(created_at: :desc).first
      
    #     if existing_log.present? && similar_query?(existing_log.query, search_query)
    #       # Update the existing log
    #       existing_log.update(query: search_query, created_at: Time.current)
    #     else
    #       # Create a new log
    #       Log.create(query: search_query, ip_address: ip_address)
    #     end
    #   end

    def log_search(search_query, ip_address)
      # Find the latest log with the same IP address
      existing_log = Log.where(ip_address: ip_address).order(created_at: :desc).first
    
      if existing_log.present? && similar_query?(existing_log.query, search_query)
        # Update the existing log
        existing_log.update(query: search_query, created_at: Time.current)
      else
        # Create a new log
        Log.create(query: search_query, ip_address: ip_address)
      end
    end
    
      
      def similar_query?(query1, query2)
        # Use Jaro-Winkler distance to check similarity
        jaro_winkler = Amatch::JaroWinkler.new(query1)
        # Consider queries as similar if the similarity is greater than 0.8
        jaro_winkler.match(query2) > 0.8
      end
  end
  