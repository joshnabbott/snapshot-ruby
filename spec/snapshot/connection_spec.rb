require File.expand_path('../../spec_helper', __FILE__)
require 'uri'

describe Snapshot::Connection do
  before(:each) do
    @connect = Snapshot::Connection.new('http://access_key:secret_key@example.com/')
  end
  
  it 'should return a valid url for the domain' do
    lambda { URI.parse(@connect.url) }.should_not raise_error(URI::InvalidURIError)
  end
end