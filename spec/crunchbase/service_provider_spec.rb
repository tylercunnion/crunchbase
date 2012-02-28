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
    
    it "should get a complete list" do
      all_sps = ServiceProvider.all
      all_sps[0].entity.name.should == all_sps[0].name
    end
    
  end
end
