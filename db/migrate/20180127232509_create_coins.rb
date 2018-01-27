class CreateCoins < ActiveRecord::Migration[5.1]
  def change
    create_table :coins do |t|
      t.string :name
      t.string :url
      t.string :symbol
      t.string :imageurl
      t.string :coinname
      t.string :fullname
      t.string :totalcoinsupply
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
