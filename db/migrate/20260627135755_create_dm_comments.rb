class CreateDmComments < ActiveRecord::Migration[8.0]
  def change
    create_table :dm_comments do |t|
      t.text :chat_body
      t.integer :chat_user_id
      t.integer :room_id
      t.timestamps
    end
  end
end
