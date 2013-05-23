require 'spec_helper'

describe Wyatt::Request do
  describe '#new' do
    let(:http_method) { 'get' }
    let(:uri) { 'www.example.com' }
    let(:body) { 'test' }
    let(:params) { { arbitrary: 'value' } }
    let(:timeout) { 2 }
    let(:open_timeout) { 3 }
    let(:request) do 
      Wyatt::Request.new(
        http_method, uri, params, 
        body, timeout: timeout, open_timeout: open_timeout
      )
    end 

    it "should initialize http method" do
      request.http_method.should == http_method
    end

    it "should initialize uri" do
      request.uri.should == uri
    end

    it "should initialize body" do
      request.body.should == body
    end

    it "should initialize params" do
      request.params.should == params
    end

    it "should initialize timeout" do
      request.timeout.should == timeout
    end

    it "should initialize open_timeout" do
      request.open_timeout.should == open_timeout
    end
  end
end
