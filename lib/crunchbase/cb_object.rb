module Crunchbase
  
  # Represents any object which can be pulled directly from the CB API.
  class CB_Object
    
    # Must be overridden in subclasses
    ENT_NAME = "undefined"
    ENT_PLURAL = "undefineds"
    
    # Returns an array of tags
    def tags
      @tag_list.respond_to?('split') ? @tag_list.split(', ') : []
    end
    
    # Returns an array of aliases
    def aliases
      @alias_list.respond_to?('split') ? @alias_list.split(", ") : []
    end
    
    # Factory method to return an instance from a permalink  
    def self.get(permalink)
      j = API.single_entity(permalink, self::ENT_NAME)
      e = self.new(j)
      return e
    end
    
    def self.find(name)
      get(API.permalink({name: name}, self::ENT_PLURAL)["permalink"])
    end
    
    def self.all
      all = API.all(self::ENT_PLURAL).map do |ent|
        ent["namespace"] = self::ENT_NAME
        EntityListItem.new(ent)
      end
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