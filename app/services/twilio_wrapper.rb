class TwilioWrapper
  def self.send_message(phone_number, alert_message, image_url=nil)
    twilio_number = ENV['TWILIO_NUMBER']
    client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    message = {
      from: twilio_number,
      to:   phone_number,
      body: alert_message
    }

    client.messages.create(message)
  end
end
