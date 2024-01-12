class School < ApplicationRecord
  has_many :users
  has_many :films, through: :users

  def self.test_fixtures
    create(name: 'columbia')
  end
end
