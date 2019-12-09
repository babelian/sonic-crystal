module Sonic
  module Channels
    class Ingest < Base
      def push(collection, bucket, object, text, lang = nil)
        #rb:
        arr = [collection, bucket, object, quote(text)]
        arr << "LANG(#{lang})" if lang

        #rb execute('PUSH', *arr)
        execute("PUSH", arr.join(" "))
      end

      def pop(collection, bucket, object, text)
        execute("POP", collection, bucket, object, quote(text))
      end

      def count(collection, bucket = nil, object = nil)
        #rb execute('COUNT', *[collection, bucket, object].compact)
        execute("COUNT", [collection, bucket, object].compact.join(" "))
      end

      def flushc(collection)
        execute("FLUSHC", collection)
      end

      def flushb(collection, bucket)
        execute("FLUSHB", collection, bucket)
      end

      def flusho(collection, bucket, object)
        execute("FLUSHO", collection, bucket, object)
      end
    end
  end
end
