require 'rest-client'
require 'twilio-ruby'
require 'cgi'

module Lita
  module Handlers
    class OnewheelAlert < Handler
      config :account_sid, required: true
      config :auth_token, required: true
      config :sms_number, required: true
      config :twilio_number, required: true
      config :alert, required: true

      route /.*/i, :alert
      http.get '/sms', :respond_sms

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
        Lita.logger.info request.env['QUERY_STRING']
        qs = CGI.parse request.env['QUERY_STRING']
        Lita.logger.info qs['Body']
        room = qs['Body'][0].match /(\#\w+)/
        room = room[1]
        Lita.logger.info room.inspect
        boo = qs['Body'][0].sub /\#\w+/, ''
        boo = "<onewheelskyward sms bridge>: #{boo}"
        Lita.logger.info boo

        robot = request.env['lita.robot']
        source = Lita::Source.new(user: nil, room: room)
        robot.send_messages(source, boo)
      end

      Lita.register_handler(self)
    end
  end
end
