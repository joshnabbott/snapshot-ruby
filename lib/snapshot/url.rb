module Snapshot
  class URL
    attr_reader :extension, :id
    
    def initialize(id, extension, &block)
      @id = id
      @extension = extension
      @options = []
      tap(&block) if block_given?
    end
    
    def method_missing(processor, *options)
      @options << [processor.to_s, options]
    end
    
    def to_s
      options = @options.flatten
      options << '' unless options.empty?
      "#{Snapshot.connection.url}#{options.join('/')}#{id}.#{extension}"
    end
  end
end