module Crunchbase
  
  # The Search class provides access to the Crunchbase search API. To perform a
  # search, call the find class method, which returns an object of the Search
  # class. This object represents an array of SearchResult objects, which may
  # be addressed in a way analogous to an Array. These results are loaded on
  # demand, in line with the CB API which returns results in pages of 10. When
  # requesting a result index that has not been loaded yet, a new request is
  # made to fetch it, resulting in a small delay. The class implements the
  # Enumerable module, allowing usage of +map+, +select+, etc. If this is not
  # sufficient, and full access to the underlying array is required, you may
  # call to_ary, which will return the entire array including all results. If
  # not all results have been fetched yet, there will be a delay to retrieve
  # them, so consider this if your search contains a large number of results.
  class Search
    include Enumerable
    
    attr_reader :size, :crunchbase_url
    alias :length :size
    
    # Performs a Crunchbase search for query.
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
    
    def [](*args)
      case args.length
      when 1
        key = args[0]
        if key.kind_of?(Integer)
          get_single_key(key)
        elsif key.kind_of?(Range)
          get_range(key)
        end
      end
    end
    
    # Returns array of all search results (not just ones currently loaded.)
    # This enables the user to take advantage of all Array methods, not just
    # the ones implmented on Search.
    def to_ary
      self.map{|result| result}
    end
    
    # Calls _block_ once for each search result, passing that item as a
    # parameter.
    def each(&block) # :yields: result
      0.upto(@size - 1) {|x| yield self[x]}
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

    def get_single_key(key)
      r = @results[key]
      unless r.nil? && key < @size
        r
      else
        retrieve_for_index(key)
        @results[key]
      end
    end

    def get_range(range)
      r = []
      enum = range.to_enum
      begin
        while (x = enum.next) < @size
          r << get_single_key(x)
        end
      rescue StopIteration
      end
      return r.empty? ? nil : r
    end
    
  end
end
