require "./base"

module Sonic
  module Channels
    class Control < Base
      def trigger(action : String)
        execute("TRIGGER", action)
      end
    end
  end
end
