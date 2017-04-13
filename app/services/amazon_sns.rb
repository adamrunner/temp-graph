class AmazonSns
  def self.send_message(phone_number, message)
    #TODO: an initializer wouldn't work, so here we configure the creds.
    Aws.config.update({
      region: 'us-west-2',
      credentials: Aws::Credentials.new(ENV["ACCESS_KEY_ID"], ENV["AWS_SECRET"])
    })

    client = Aws::SNS::Client.new
    client.publish({
      phone_number: phone_number,
      message: message
      })
  end
end
