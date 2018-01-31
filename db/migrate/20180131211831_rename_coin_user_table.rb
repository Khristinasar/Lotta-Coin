class RenameCoinUserTable < ActiveRecord::Migration[5.1]
  def change
    rename_table :coins_users, :user_coins
  end
end
