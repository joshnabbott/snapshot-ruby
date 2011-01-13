Snapshot
========

The Snapshot gem provides an nice, ActiveRecord-ish interface to the
[Snapshot](http://snapshothq.com/) API.

* [Fork the code on Github](https://github.com/jeremyboles/snapshot-ruby)

Installation
------------

    gem install snapshot-rb

Using the gem
-------------

    require 'rubygems'
    require 'snapshot'

### Connecting the Client ###

    Snapshot.configure do |config|
      config.domain = 'yourdomain.snapshothq.com'
      config.access_key = 'your access key'
      config.secret_key = 'your secret key'
    end
    
    # or with a hash
    Snapshot.configure({:access_key => ...})
    
### Typical Usage ###

The API for the gem was modeled after ActiveRecord to make it easy to pick up.
Uploading a video to Snapshot is done with via the `create` method:

    img = Snapshot::Image.create('example.jpg')
    # => #<Snapshot::Image:0x00000100a51080>
    
    img.id
    # => 'adf4675e46a6078c1bbc6a663a47e1e56e4622e5'
    
    img.created_at
    # => 2011-01-13 15:30:34 -0600
    
    img.format
    # => "JPEG"
    
    img.width
    # => 720
    
    img.height
    # => 640
    
Once and image has been uploaded, you can reference and process the image based on its `id`:

    img = Snapshot::Image.find('adf4675e46a6078c1bbc6a663a47e1e56e4622e5')
    # => #<Snapshot::Image:0x000001008a3df0>
    
    img = Snapshot::Image.find('wrong id')
    # => nil
    
To delete an image, call its `destroy` method:

    img.destroy
    # => true
    