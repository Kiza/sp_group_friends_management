class CreateFriendships < ActiveRecord::Migration[5.1]
  def change
    create_table :friendships do |t|
      t.string :user, null: false
      t.string :friend, null: false

      t.timestamps
    end


    add_index :friendships, :user
    add_index :friendships, :friend
    add_index :friendships, [:user, :friend], unique: true
  end
end
