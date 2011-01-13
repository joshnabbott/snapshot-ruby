require 'uri'

module Snapshot
  class Connection
    attr_accessor :access_key, :domain, :secret_key
    
    def initialize(opts={})
      if opts.is_a?(Hash)
        opts.each do |m,v|
          self.send("#{m}=", v)
        end
      else
        uri = URI.parse(opts)
        self.access_key, self.domain, self.secret_key = uri.user, uri.host, uri.password
        self.domain << ":#{uri.port}" unless uri.port == 80
      end
    end
    
    def resource
      @resource ||= RestClient::Resource.new(self.url, {
        :user => self.access_key,
        :password => self.secret_key
      })
    end
    
    def url
      "http://#{domain}/"
    end
  end
end