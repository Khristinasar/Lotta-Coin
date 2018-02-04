class TrackerSm < ApplicationRecord
   def tracker_twl
     account_sid = ENV['ACCOUNT_SID'] # Your Account SID from www.twilio.com/console
     auth_token = ENV['AUTH_TOKEN']   # Your Auth Token from www.twilio.com/console
     @client = Twilio::REST::Client.new account_sid, auth_token
     message = @client.messages.create(
         body: "Hi, Tim. This is Frank talking directly from Ruby",
         to: "7865014449",  # Replace with your phone number
         from: "8285855546")  # Replace with your Twilio number
     puts message.sid
   end
end
