require 'rest-client'
require 'twilio-ruby'

module Lita
  module Handlers
    class OnewheelAlert < Handler
      config :account_sid, required: true
      config :auth_token, required: true
      config :sms_number, required: true
      config :twilio_number, required: true

      route /.*onewheelskyward.*/i,
            :alert
      route /.*ows.*/i,
            :alert

      def alert(response)
        Lita.logger.debug "Heard #{response.matches[0]}"
        client = Twilio::REST::Client.new config.account_sid, config.auth_token
        message = client.messages.create(
          body: response.matches[0],
          to: config.sms_number,
          from: config.twilio_number
        )
        Lita.logger.debug "Message SID: #{message.sid}"
      end

      Lita.register_handler(self)
    end
  end
end
