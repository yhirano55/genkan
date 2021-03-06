class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string   :email,           null: false
      t.string   :remember_token,  null: false
      t.integer  :logged_in_count, null: false, default: 0
      t.datetime :last_logged_in_at
      t.datetime :accepted_at
      t.datetime :banned_at

      t.timestamp

      t.index :email, unique: true
      t.index :remember_token, unique: true
    end
  end
end
