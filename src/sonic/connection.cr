require "socket"
require "./errors"

module Sonic
  class Connection
    def self.connect(*args)
      connection = new(*args)
      connection.connect || raise "could not connect" #rb connection if connection.connect
      connection
    end

    def initialize(@host : String, @port : String | Int32, @channel_type : Symbol, @password : String | Nil) #rb password = nil

    end

    def connect
      read # ...
      write(["START", @channel_type, @password].compact.join(" "))
      read =~ /^STARTED / ? true : false # rb.start_with?("STARTED ")
    end

    def disconnect
      socket.close
    end

    def read
      data = (socket.gets || "").chomp
      raise ServerError.new(data) if data =~ /^ERR / #rb raise ServerError, data if data.start_with?('ERR ')

      data
    end

    def write(data)
      socket.puts(data)
    end

    #rb private

    private def socket
      @socket ||= TCPSocket.new(@host, @port) #rb TCPSocket.open
    end
  end
end
