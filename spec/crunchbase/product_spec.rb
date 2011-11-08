require File.join(File.dirname(__FILE__), "..", "spec_helper.rb")

module Crunchbase
  describe Product do
    
    it "should pull from web api" do
      product = Product.get("iphone")
      product.name.should == "iPhone"
    end
    
    it "should return date for launched" do
      product = Product.new({"launched_year" => 2004, "launched_month" => 2,
        "launched_day" => 1, "created_at" => "Sat Dec 22 08:42:28 UTC 2007",
        "updated_at" => "Sat Dec 22 08:42:28 UTC 2007", "company" => {}})
      product.launched.should === Date.new(2004, 2, 1)
    end
    
    it "should return date for deadpooled" do
      product = Product.new({"deadpooled_year" => 2004, "deadpooled_month" => 2,
        "deadpooled_day" => 1, "created_at" => "Sat Dec 22 08:42:28 UTC 2007",
        "updated_at" => "Sat Dec 22 08:42:28 UTC 2007", "company" => {}})
      product.deadpooled.should === Date.new(2004, 2, 1)
    end
  end
end