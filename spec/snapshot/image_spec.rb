require File.expand_path('../../spec_helper', __FILE__)

describe Snapshot::Image do
  before do
    Snapshot.configure('http://access_key:secret_key@example.com/')
  end
  
  after do
    Snapshot.disconnect!
  end
  
  
end