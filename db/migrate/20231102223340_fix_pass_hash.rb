class FixPassHash < ActiveRecord::Migration[7.1]
  def change
    change_table :users do |t|
      t.string :password_digest
      remove_column :users, :pw_hash
    end
  end
end
