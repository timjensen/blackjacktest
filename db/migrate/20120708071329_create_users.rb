class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :first_name
      t.string :oauth_token
      t.string :picture
      t.datetime :oauth_expires_at
      t.integer :bankroll, :default => "2000"

      t.timestamps
    end
  end
end
