require File.join(File.dirname(__FILE__), "..", "spec_helper.rb")
require 'net/http'

module Crunchbase
  describe API do
    
    it "should return a JSON hash" do
      j = API.fetch('steve-jobs', 'person')
      j.class.should == Hash
    end
    
    it "should return JSON from person permalink" do
      j = API.person("steve-jobs")
      j.class.should == Hash
    end
    
    it "should raise exception on unfound person" do
      expect { API.person("not-real") }.to raise_error
    end
    
    it "should follow redirects" do
      c = Company.get("adobe")
      c.name.should == "Adobe Systems"
    end

    it "should find a permalink from a well-formed search" do
      j = API.permalink({name: "Accel Partners"}, "financial-organizations")
      j.class.should == Hash
      j["permalink"].should == 'accel-partners'
    end

  end
end
