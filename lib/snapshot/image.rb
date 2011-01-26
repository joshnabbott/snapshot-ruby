require 'json'
require 'rest_client'

module Snapshot
  class Image
    attr_accessor :created_at, :filesize, :format, :height, :id, :width
    
    class << self
      # Uploads a file to the connected Snapshot account. 
      #
      # ==== Parameters
      #
      # * +file+ - File or path to a file
      #
      # ==== Examples
      #
      #   # With a path:
      #   img = Snapshot::Image.create('example.jpg')
      #
      #   # With a file:
      #   file = File.open('example.jpg')
      #   img = Snapshot::Image.create(file)
      #
      def create(file)
        file = File.open(file) if file.is_a?(String)
        result = Snapshot.connection.resource.post(:file => file)
        info = JSON.parse(result)['file']
        
        self.new.tap do |img|
          img.created_at = Time.at(info['uploaded_at'].to_i)
          img.filesize = info['size'].to_i
          img.format = info['type']
          img.height = info['height'].to_i
          img.id = info['id']
          img.width = info['width'].to_i
        end
      end
      
      # Finds a file on the connected Snapshot account.
      #
      # ==== Parameters
      #
      # * +id+ - The ID of the image 
      #
      # ==== Examples
      #
      #   Snapshot::Image.find('a45af9b9e6ebab9c685faef4e72e7a14f3e24e1a')
      #
      def find(id)
        result = Snapshot.connection.resource["#{id}"].get
        info = JSON.parse(result)
        
        self.new.tap do |img|
          img.created_at = Time.at(info['uploaded_at'].to_i)
          img.filesize = info['size'].to_i
          img.format = info['type']
          img.height = info['height'].to_i
          img.id = info['id']
          img.width = info['width'].to_i
        end
      rescue RestClient::ResourceNotFound
        nil
      end
    end

    # Removes the image from the connect Snapshot account
    #
    # ==== Examples
    #
    #   img = Snapshot::Image.find('a45af9b9e6ebab9c685faef4e72e7a14f3e24e1a')
    #   img.destroy
    #
    def destroy
      Snapshot.connection.resource["#{id}"].delete
      true
    rescue RestClient::ResourceNotFound
      nil
    end
    
    # Return the URL of the image
    #
    # ==== Examples
    #
    #   img = Snapshot::Image.find('a45af9b9e6ebab9c685faef4e72e7a14f3e24e1a')
    #   img.url # => http://subdomain.snapshothq.com/a45af9b9e6ebab9c685faef4e72e7a14f3e24e1a.jpg
    #
    def url(&block)
      Snapshot::URL.new(id, extension, &block)
    end
  
  private
  
    def extension
      case self.format
        when 'JPEG' then '.jpg'
        when 'PNG' then '.png'
      end
    end
    
  end
end