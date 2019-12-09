require "./connection"
require "./channels/*"
module Sonic
  class Client
    def initialize(@host : String, @port : String | Int32, @password : String)
    end

    def channel(type : Symbol)
      channel_class(type).new(Connection.connect(@host, @port, type, @password))
    end

    #rb private

    def channel_class(type : Symbol)
      case type #rb .to_sym
      when :control then Channels::Control
      when :ingest then Channels::Ingest
      when :search then Channels::Search
      else raise ArgumentError.new("`#{type}` channel type is not supported")
      end
    end
  end
end