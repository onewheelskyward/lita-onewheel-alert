require 'rest-client'

module Lita
  module Handlers
    class OnewheelAlert < Handler
      route /.*onewheelskyward.*/i,
            :alert

      def alert(response)
        response.reply "Heard #{response.matches[0]}"
      end

      Lita.register_handler(self)
    end
  end
end
