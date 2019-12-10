require "../connection"

module Sonic
  module Channels
    abstract class Base
      getter connection : Connection #rb attr_reader :connection

      def initialize(connection : Connection)
        @connection = connection
      end

      def ping
        execute("PING")
      end

      def help(manual)
        execute("HELP", manual)
      end

      # cr
      def info
        execute("INFO")
      end

      def quit
        execute("QUIT")
        connection.disconnect
      end

      #rb private

      private def execute(*args)
        connection.write(args.to_a.compact.join(' ')) #rb *args.join
        # yield if block_given? #rb overloaded below
        type_cast_response(connection.read)
      end

      private def execute(*args)
        connection.write(args.to_a.compact.join(' '))
        yield
        type_cast_response(connection.read)
      end

      private def quote(value)
        "\"#{value}\""
      end

      private def type_cast_response(value)
        if value == "OK"
          true
        elsif value =~ /^RESULT \d/ #rb value.start_with?("RESULT ") #cr added \d as INFO returns a string result
          value.split(" ").last.to_i
        elsif value =~ /^EVENT / #rb value.start_with?("EVENT ")
          value.split(" ")[3..-1].join(" ")
        else
          value
        end
      rescue error
        puts "Value was: #{value.inspect}"
        raise error
      end
    end
  end
end

#cr abstract Control methods required for static type checking
module Sonic
  module Channels
    abstract class Base

      #
      # Control
      #

      def trigger(action)
      end

      #
      # Injest
      #

      def push(collection, bucket, object, text, lang = nil)
      end

      def pop(collection, bucket, object, text)
      end

      def count(collection, bucket = nil, object = nil)
      end

      def flushc(collection)
      end

      def flushb(collection, bucket)
      end

      def flusho(collection, bucket, object)
      end

      #
      # Search
      #

      def query(collection, bucket, terms, limit = nil, offset = nil, lang = nil)
      end

      def suggest(collection, bucket, word, limit = nil)
      end
    end
  end
end