module Crunchbase
  
  # Represents any object which can be pulled directly from the CB API.
  class CB_Object

    # Returns an array of tags
    def tags
      @tag_list.respond_to?('split') ? @tag_list.split(', ') : []
    end
    
    # Returns an array of aliases
    def aliases
      @alias_list.respond_to?('split') ? @alias_list.split(", ") : []
    end
    
    
    # Compares two objects, returning true if they have the same permalink
    # (ie, represent the same entity). If you must ensure that the two objects
    # also contain the same data, you should also compare the updated_at
    # attributes.
    def ===(other)
      @permalink == other.permalink
    end
    
  end
end