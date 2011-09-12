module Crunchbase
  class CB_Object

    # Returns an array of tags
    def tags
      @tag_list.respond_to?('split') ? @tag_list.split(', ') : []
    end
    
    def aliases
      @alias_list.respond_to?('split') ? @alias_list.split(", ") : []
    end
    
    def ===(other)
      @permalink == other.permalink && @updated_at == other.updated_at
    end
    
  end
end