require File.join(File.dirname(__FILE__), "..", "spec_helper.rb")
require 'net/http'

module Crunchbase
  describe Search do
    
    it "should retrieve search results" do
      s = Search.find('google')
      s[0].class.should == SearchResult
    end
    
    describe "advanced indexing" do
      before(:all) do
        @s = Search.find('google')
      end

      it "should return slices with ranges" do
        slice = @s[8..11]
        slice.class.should == Array
        slice[0].class.should == SearchResult
      end

      it "should return abbreviated slice for range with upper out of range" do
        slice = @s[@s.size-3..@s.size+2]
        slice.length.should == 3
      end

      it "should return nil for slice out of range" do
        slice = @s[@s.size..@s.size+4]
        slice.should == nil
      end

    end #Indexing 

    it "should accept negative indices" do
      s = Search.find('google')
      s[-13].should == s[s.size-13]
      s[-13].class.should == SearchResult
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
