class CreateDmUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :dm_users do |t|
      t.integer :chat_user_id
      t.integer :room_id
      t.timestamps
    end
  end
end
