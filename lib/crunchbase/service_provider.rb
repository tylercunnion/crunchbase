require 'date'
module Crunchbase
  class ServiceProvider < CB_Object
    
    attr_reader :name, :permalink, :crunchbase_url, :homepage_url,
      :phone_number, :tag_list, :alias_list, :created_at, :updated_at,
      :overview, :image, :offices, :providerships, :external_links
      
    def self.get(permalink)
      j = API.service_provider(permalink)
      s = ServiceProvider.new(j)
      return s
    end
    
    
  end
end