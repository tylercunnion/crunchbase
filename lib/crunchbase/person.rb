module Crunchbase
  class Person
        
    def first_name
      return "Brad"
    end
    
    def self.get(permalink)
      json_string = API.person(permalink)
      return Person.new
    end
    
  end
end