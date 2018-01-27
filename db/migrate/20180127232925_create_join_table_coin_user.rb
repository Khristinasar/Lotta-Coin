class CreateJoinTableCoinUser < ActiveRecord::Migration[5.1]
  def change
    create_join_table :coins, :users do |t|
    t.index [:coin_id, :user_id]
    end
  end
end
