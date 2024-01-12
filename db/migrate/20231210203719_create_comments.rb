class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.string :username
      t.text :body
      t.references :film, null: false, foreign_key: true

      t.timestamps
    end
  end
end
