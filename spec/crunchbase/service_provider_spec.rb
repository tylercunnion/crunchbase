require File.join(File.dirname(__FILE__), "..", "spec_helper.rb")

module Crunchbase
  describe ServiceProvider do
    
    it "should pull from web api" do
      sp = ServiceProvider.get("fox-rothschild")
      sp.name.should == "Fox Rothschild"
    end

    it "should find by name" do
      sp = ServiceProvider.find("Fox Rothschild")
      sp.permalink.should == "fox-rothschild"
    end
    
  end
end
