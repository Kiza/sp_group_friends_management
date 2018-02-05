class CreateBlacklists < ActiveRecord::Migration[5.1]
  def change
    create_table :blacklists do |t|
      t.string :by_user, null: false
      t.string :blocked, null: false

      t.timestamps
    end

    add_index :blacklists, :blocked
    add_index :blacklists, :by_user
    add_index :blacklists, [:by_user, :blocked], unique: true
  end
end
