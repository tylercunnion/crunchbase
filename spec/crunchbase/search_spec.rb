require File.join(File.dirname(__FILE__), "..", "spec_helper.rb")
require 'net/http'

module Crunchbase
  describe Search do
    
    it "should retrieve search results" do
      s = Search.find('google')
      s[0].class.should == SearchResult
    end
    
    it "should return higher search results" do
      s = Search.find('google')
      s[s.size/2].class.should == SearchResult
    end
    
    it "should return nil for array out of bounds" do
      s = Search.find('google')
      s[s.size].should be_nil
    end

  end
end
