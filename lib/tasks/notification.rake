namespace :notification do
  desc "Alert sender: if a users alert thresholds are reached send alert"
  task :alert_sender => :environment do
   coins_with_alerts = UserCoin.where(is_receiving_alert: true)
   coins_with_alerts.each do |coin|
     if coin.current_price > coin.amount_up || coin.current_price < coin.amount_down
       coin.alert_user
     end
   end
  end
end
