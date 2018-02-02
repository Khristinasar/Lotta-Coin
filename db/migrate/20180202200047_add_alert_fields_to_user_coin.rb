class AddAlertFieldsToUserCoin < ActiveRecord::Migration[5.1]
  def change
    add_column :user_coins, :amount_up, :decimal
    add_column :user_coins, :amount_down, :decimal
    add_column :user_coins, :is_receiving_alert, :boolean, default: false
  end
end
