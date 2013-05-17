require 'spec_helper'

describe Wyatt::Response do

  let(:faraday_body)     { {} }
  let(:faraday_status)   { 200 }
  let(:faraday_response) { mock(:body=>faraday_body, :status=>faraday_status) }
  let(:response)         { Wyatt::Response.new(faraday_response) }

  describe '#initialize' do

    it 'should initialize the value of faraday_response' do
      response.faraday_response.should eq(faraday_response)
    end

  end

  describe '#body' do

    it 'should return the result of faraday_response.body' do
      faraday_response.stub(:body) { faraday_body }
      response.body.should eq(faraday_body)
    end

  end

  describe '#status' do

    it 'should return the result of faraday_response.status' do
      faraday_response.stub(:body) { faraday_status }
      response.body.should eq(faraday_status)
    end

  end

end

