require File.join(File.dirname(__FILE__), "..", "spec_helper.rb")

module Crunchbase
  describe ServiceProvider do
    
    it "should pull from web api" do
      sp = ServiceProvider.get("fox-rothschild")
      sp.name.should == "Fox Rothschild"
    end    
    
    it "should return date for founded" do
      sp = ServiceProvider.new({"founded_year" => 2004, "founded_month" => 2,
        "founded_day" => 1, "created_at" => "Sat Dec 22 08:42:28 UTC 2007",
        "updated_at" => "Sat Dec 22 08:42:28 UTC 2007"})
      sp.founded.should === Date.new(2004, 2, 1)
    end
    
  end
end