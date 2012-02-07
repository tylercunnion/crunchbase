module Crunchbase
  class Search
    include Enumerable
    
    attr_reader :size, :crunchbase_url
    
    def self.find(query)
      j = API.search(query)
      s = Search.new(query, j)
    end
    
    def initialize(query, json)
      @query = query
      @results = []
      @size = json["total"]
      @crunchbase_url = json["crunchbase_url"]
      populate_results(json)
    end
    
    def [](key)
      if key.kind_of?(Integer)
        r = @results[key]
        unless r.nil? && key < @size
          r
        else
          retrieve_for_index(key)
          @results[key]
        end
      end
    end
    
    def each(&block)
      0.upto(@size - 1) {|x| yield self[x]}
    end
    
    def length
      size
    end
    
    private
    
    def populate_results(json)
      page = json["page"]
      results = json["results"].map{|r| SearchResult.new(r)}
      start = (page - 1) * 10
      @results[start, results.length] = results
    end
    
    def retrieve_for_index(index)
      page = (index / 10) + 1
      populate_results(API.search(@query, page))
    end
  end
end