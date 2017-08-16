class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :provider,  null: false
      t.string :uid,       null: false
      t.string :nickname,  null: false
      t.string :image_url, null: false
      t.string :twitter_consumer_key
      t.string :twitter_consumer_secret
      t.string :twitter_access_token
      t.string :twitter_access_token_secret

      t.timestamps
    end

    add_index :users, [:provider, :uid], unique: true
  end
end
