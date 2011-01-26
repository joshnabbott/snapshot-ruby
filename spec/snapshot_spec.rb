require File.expand_path('../spec_helper', __FILE__)

describe Snapshot do
  after(:each) do
    Snapshot.disconnect!
  end
  
  it 'should raise an error if used without being connected' do
    lambda { Snapshot.connection }.should raise_error
  end
  
  it 'should be able to be configured by a String' do
    Snapshot.configure("http://access_key:secret_key@example.com/")
    lambda { Snapshot.connection }.should_not raise_error
  end
  
  it 'should be able to be configured by a Hash' do
    Snapshot.configure(:access_key => 'access_key', :secret_key => 'secret_key', :domain => 'example.com')
    lambda { Snapshot.connection }.should_not raise_error
  end
  
  it 'should be able to be configured by a block' do
    Snapshot.configure do |config|
      config.access_key = 'access_key'
      config.domain = 'example.com'
      config.secret_key = 'secret_key'
    end
    lambda { Snapshot.connection }.should_not raise_error
  end
  
  it 'should be able to be disconnected' do
    Snapshot.configure("http://access_key:secret_key@example.com/")
    Snapshot.disconnect!
    lambda { Snapshot.connection }.should raise_error
  end
end