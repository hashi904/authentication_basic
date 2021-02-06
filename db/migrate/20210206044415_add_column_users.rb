class AddColumnUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :password_digest, :string, null: false
    change_column_null :users, :nickname, false
    change_column_null :users, :email, false
  end
end
