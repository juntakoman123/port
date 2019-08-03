class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.string :content
      t.integer :user_id
      t.timestamps
      t.index :user_id
      t.index :created_at
    end
  end
end
