require 'snapshot/connection'
require 'snapshot/image'

module Snapshot
  extend self
  
  def configure(opts={})
    if opts
      connect!(opts)
    else
      yield @connection = Connection.new
    end
  end
  
  def connect!(opts=nil)
    opts = ENV['SNAPSHOT_URL'] if opts.nil?
    @connection = Connection.new(opts)
  end
  
  def connection
    raise 'Not connected. Please connect! first.' unless @connection
    @connection
  end
end