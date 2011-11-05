module Crunchbase
  class PersonRelationship < Relationship
    
    attr_reader :person_first_name, :person_last_name, :person_permalink
    
    def self.array_from_relationship_list #:nodoc:
      raise CrunchException, "Method must be called from superclass Relationship"
    end
    
    def initialize(hash)
      super(hash)
      @person_first_name = hash["person"]["first_name"]
      @person_last_name = hash["person"]["last_name"]
      @person_permalink = hash["person"]["permalink"]
    end
    
    # Returns a representation of the associated person, loading from memory
    # if previously fetched, unless force_reload is set to true.
    def person(force_reload=false)
      return @person unless @person.nil? || force_reload
      @person = Person.get(@person_permalink)
    end
    
  end
end