class AddIdColumnToUserCoins < ActiveRecord::Migration[5.1]
  def change
    add_column :user_coins, :id, :primary_key
  end
end
