require 'snapshot/connection'
require 'snapshot/image'
require 'snapshot/url'
require 'snapshot/version'

module Snapshot
  extend self
  
  # Configures and connects to Snapshot.
  #
  # ==== Parameters
  #
  # * +opts+ - String or Hash 
  # * +block+ - The block is optional and is passed a Connection object
  #
  # ==== Examples
  #
  #   # Using a String:
  #   Snapshot.configure('http://access_key:secret_ket@subdomain.snapshothq.com/')
  #
  #   # Using a Hash:
  #   Snapshot.configure(:access_key => 'access_key', :domain => 'subdomain.snapshothq.com', :secret_key => 'secret_key')
  #
  #   # Using a block:
  #   Snapshot.configure do |config|
  #     config.access_key = 'access_key'
  #     config.domain = 'subdomain.snapshothq.com'
  #     config.secret_key = 'secret_key
  #   end
  #
  def configure(opts=false)
    if opts
      connect!(opts)
    else
      yield @connection = Connection.new
    end
  end
  
  # Connects the library to Snapshot. If no connection options are given, the
  # method will try to use the environment variable <code>SNAPSHOT_URL</code>.
  #
  # ==== Parameters
  #
  # * +opts+ - (optional) String or Hash 
  #
  # ==== Examples
  #
  #   # Using a String:
  #   Snapshot.connect!('http://access_key:secret_ket@subdomain.snapshothq.com/')
  #
  #   # Using a Hash:
  #   Snapshot.connect!(:access_key => 'access_key', :domain => 'subdomain.snapshothq.com', :secret_key => 'secret_key')
  #
  def connect!(opts=nil)
    opts = ENV['SNAPSHOT_URL'] if opts.nil?
    @connection = Connection.new(opts)
  end
  
  # Returns the connection for the library. Will raise an error if the
  # library has not been connected via the <code>connect!</code> method
  #
  def connection
    raise 'Not connected. Please connect! first.' unless @connection
    @connection
  end
  
  # Terminates the connection to Snapshot
  def disconnect!
    @connection = nil
  end
end