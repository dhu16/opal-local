class User < ApplicationRecord
  include ActiveModel::SecurePassword
  has_secure_password
  has_secure_password :recovery_password, validations: false

  belongs_to :school
  has_many :films
  has_many :favorites
  has_many :favorite_films, through: :favorites, source: :film
  has_many :comments
  
  def self.from_table(table)
    table.hashes.each do |row|
      row['password'] = '123456'
      row['school'] = School.find_by(name: 'columbia')
      User.create(row)
    end
  end

  def self.with_email(addr)
    User.find_by(email: addr)
  end

  def profile_path
    "/users/#{id}"
  end
end
