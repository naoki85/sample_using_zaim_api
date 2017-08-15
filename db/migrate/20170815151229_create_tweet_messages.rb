class CreateTweetMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :tweet_messages do |t|
      t.integer :user_id,   null: false
      t.string  :message,   null: false
      t.integer :threshold, null: false
      t.integer :condition, null: false, limit: 1

      t.timestamps
    end
  end

  add_index :tweet_messages, :user_id
end
