module Sonic
  module Channels
    class Search < Base
      def query(collection, bucket, terms, limit = nil, offset = nil, lang = nil)
        arr = [collection, bucket, quote(terms)]
        arr << "LIMIT(#{limit})" if limit
        arr << "OFFSET(#{offset})" if offset
        arr << "LANG(#{lang})" if lang

        execute("QUERY", arr.join(" ")) do #rb *arr
          connection.read
        end
      end

      def suggest(collection, bucket, word, limit = nil)
        arr = [collection, bucket, quote(word)]
        arr << "LIMIT(#{limit})" if limit

        execute("SUGGEST", arr.join(" ")) do #rb: *arr
          connection.read
        end
      end
    end
  end
end
