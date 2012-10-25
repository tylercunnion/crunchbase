require File.join(File.dirname(__FILE__), "..", "spec_helper.rb")
require 'net/http'

module Crunchbase
  describe API do

    it "should raise exception for missing API key" do
      key = API.key
      API.key = nil
      expect { API.fetch('steve-jobs', 'person') }.to raise_error
      API.key = key
    end

    it "should remove control characters" do
      cargurus = File.open(File.join(File.dirname(__FILE__), "..", "fixtures", "cargurus.js")).read
      API.should_receive(:get_url_following_redirects).with(/^http:\/\/api.crunchbase.com\/v\/1\/company\/cargurus.js/, 2).and_return(cargurus)
      lambda { API.single_entity("cargurus", "company") }.should_not raise_error
    end
    
    it "should return a JSON hash" do
      j = API.fetch('steve-jobs', 'person')
      j.class.should == Hash
    end
    
    it "should return JSON from person permalink" do
      j = API.single_entity("steve-jobs", "person")
      j.class.should == Hash
    end
    
    it "should raise exception on unfound person" do
      expect { API.single_entity("not-real", "person") }.to raise_error, "Sorry, we could not find the record you were looking for."
    end
    
    it "should raise exception for incorrect entity name" do
      expect { API.single_entity("whatever", "wrong") }.to raise_error, "Unsupported Entity Type"
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
