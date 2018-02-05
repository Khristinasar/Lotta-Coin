class AddColumnsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :phone_number, :string
    add_column :users, :text_pref, :boolean
  end
end
