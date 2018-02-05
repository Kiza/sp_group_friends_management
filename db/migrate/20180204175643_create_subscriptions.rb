class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.string :by_user, null: false
      t.string :to_user, null: false
    
      t.timestamps
    end

    add_index :subscriptions, :by_user
    add_index :subscriptions, :to_user
    add_index :subscriptions, [:by_user, :to_user], unique: true
  end
end
