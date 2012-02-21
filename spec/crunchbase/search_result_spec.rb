require File.join(File.dirname(__FILE__), "..", "spec_helper.rb")
require 'net/http'

module Crunchbase
  describe SearchResult do
    
    before(:all) do
      @result = Search.find('google')[0]
    end
    
    it "should return the entity which is named" do
      @result.name.should == @result.entity.name
    end

  end
end
