class AddUserToSchool < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :school, foreign_key: true, default: nil
  end
end
