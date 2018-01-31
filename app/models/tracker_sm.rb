class TrackerSm < ApplicationRecord
  def tracker_twl
    account_sid = "AC1f835a3e9afbdc2650b6e850d086e9eb" # Your Account SID from www.twilio.com/console
    auth_token = "a16480b82df2d8fb65f3a9229c76bc90"   # Your Auth Token from www.twilio.com/console
    @client = Twilio::REST::Client.new account_sid, auth_token
    message = @client.messages.create(
        body: "Hi, Tim. This is Frank talking directly from Ruby",
        to: "5614369413",  # Replace with your phone number
        from: "8285855546")  # Replace with your Twilio number
    puts message.sid
  end
end
