class InitialSchema < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :pw_hash
      t.string :display_name
      t.timestamps
    end
    create_table :films do |t|
      t.string :title
      t.text :description
      t.belongs_to :user
      t.timestamps
    end
    add_reference(:films, :users)
  end
end
