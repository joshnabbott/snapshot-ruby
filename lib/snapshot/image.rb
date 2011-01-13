require 'json'
require 'rest_client'

module Snapshot
  class Image
    attr_accessor :created_at, :filesize, :format, :height, :id, :width
    
    class << self
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

    def destroy
      Snapshot.connection.resource["#{id}"].delete
      true
    rescue RestClient::ResourceNotFound
      nil
    end
    
    def url
      Snapshot.connection.url << id << extension
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