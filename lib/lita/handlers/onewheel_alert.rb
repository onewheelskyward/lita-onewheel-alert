require 'rest-client'
require 'twilio-ruby'

module Lita
  module Handlers
    class OnewheelAlert < Handler
      config :account_sid, required: true
      config :auth_token, required: true
      config :sms_number, required: true
      config :twilio_number, required: true
      config :alert, required: true

      route /.*/i, :alert
      http.post "/sms", :respond_sms

      def alert(response)
        # Lita.logger.debug "Checking for match of #{config.alert} in #{response.matches[0]}"
        if response.matches[0].match /#{config.alert}/
          Lita.logger.debug "Heard #{response.matches[0]}"
          client = Twilio::REST::Client.new config.account_sid, config.auth_token
          message = client.messages.create(
            body: "[#{response.message.source.room}] <#{response.message.user.name}> #{response.matches[0]}",
            to: config.sms_number,
            from: config.twilio_number
          )
          Lita.logger.debug "Message SID: #{message.sid}"
        end
      end

      def respond_sms(request, response)
        Lita.logger.info request.inspect
        response.body << "Hello, #{request.body}!"
      end

      Lita.register_handler(self)
    end
  end
end
