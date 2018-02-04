class CreateTrackerSms < ActiveRecord::Migration[5.1]
  def change
    create_table :tracker_sms do |t|

      t.timestamps
    end
  end
end
