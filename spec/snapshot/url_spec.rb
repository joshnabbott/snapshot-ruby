require File.expand_path('../../spec_helper', __FILE__)

describe Snapshot::URL do
  before(:all) do
    Snapshot.configure('http://access_key:secret_key@example.com/')
  end
  
  before(:each) do
    @url = Snapshot::URL.new('id', 'jpg')
  end
  
  after(:all) do
    Snapshot.disconnect!
  end
  
  it 'should construct a valid url' do
    @url.to_s.should eql('http://example.com/id.jpg')
  end
  
  it 'should build processing on the url' do
    @url.size 200,150
    @url.quality 75
    @url.to_s.should eql('http://example.com/size/200/150/quality/75/id.jpg')
  end
end